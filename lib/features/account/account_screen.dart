import 'package:fit_tick_mobile/features/account/account_bloc.dart';
import 'package:fit_tick_mobile/features/account/account_event.dart';
import 'package:fit_tick_mobile/features/account/account_state.dart';
import 'package:fit_tick_mobile/ui/standard_screen.dart';
import 'package:fit_tick_mobile/ui/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountBloc>(context);

    // Trigger initial check if not already done (might be redundant if bloc does it)
    // Consider triggering check in initState or constructor of bloc if needed only once.
    bloc.add(AccountCheckStatus());

    // Use BlocBuilder directly to return the correct screen based on state
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AccountLogin && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        } else if (state is AccountSignUp && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        final String topBarTitle = 'Account';
        if (state is AccountLoading || state is AccountInitial) {
          return FitTickStandardScreen(
            topBarTitle: topBarTitle,
            pageTitle: 'Loading...',
            children: [Center(child: CircularProgressIndicator())],
          );
        }

        if (state is AccountLoggedIn) {
          return FitTickStandardScreen(
            topBarTitle: topBarTitle,
            pageTitle: 'Welcome',
            children: [_buildLoggedInView(context, state, bloc)],
          );
        }

        if (state is AccountLogin) {
          return FitTickStandardScreen(
            topBarTitle: topBarTitle,
            pageTitle: 'Login',
            children: [
              _buildAuthForm(context, bloc, isLogin: true, error: state.error),
            ],
          );
        }

        if (state is AccountSignUp) {
          return FitTickStandardScreen(
            topBarTitle: topBarTitle,
            pageTitle: 'Sign Up',
            children: [
              _buildAuthForm(context, bloc, isLogin: false, error: state.error),
            ],
          );
        }

        // Fallback for unexpected states (like AccountError if not handled above)
        return FitTickStandardScreen(
          topBarTitle: topBarTitle,
          pageTitle: 'Error',
          children: [
            Center(
              child: Text(
                state is AccountError ? state.message : 'Something went wrong.',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoggedInView(
    BuildContext context,
    AccountLoggedIn state,
    AccountBloc bloc,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Email: ${state.user.email ?? 'Anonymous'}',
            textAlign: TextAlign.center,
          ),
          Text('UID: ${state.user.uid}', textAlign: TextAlign.center),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              bloc.add(AccountLogOutRequested());
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthForm(
    BuildContext context,
    AccountBloc bloc, {
    required bool isLogin,
    String? error,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FitTickTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            textCapitalization: TextCapitalization.none,
            errorText:
                error != null && error.toLowerCase().contains('email')
                    ? error
                    : '',
          ),
          const SizedBox(height: 16),
          FitTickTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            isPassword: true,
            errorText:
                error != null && error.toLowerCase().contains('password')
                    ? error
                    : '',
          ),
          // Display general errors not specific to fields
          if (error != null &&
              !error.toLowerCase().contains('email') &&
              !error.toLowerCase().contains('password'))
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                error,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();
              if (email.isEmpty || password.isEmpty) {
                // Basic validation, could be more sophisticated
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email and password cannot be empty.'),
                  ),
                );
                return;
              }
              if (isLogin) {
                bloc.add(
                  AccountLoginRequested(email: email, password: password),
                );
              } else {
                bloc.add(
                  AccountSignUpRequested(email: email, password: password),
                );
              }
            },
            child: Text(isLogin ? 'Login' : 'Sign Up'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _emailController.clear();
              _passwordController.clear();
              bloc.add(AccountToggleMode());
            },
            child: Text(
              isLogin
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Login',
            ),
          ),
        ],
      ),
    );
  }
}
