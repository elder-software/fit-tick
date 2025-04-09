import 'package:flutter/material.dart';

class FitTickStandardScreen extends StatelessWidget {
  final String topBarTitle;
  final String pageTitle;
  final Widget? pageTitleButtons;
  final List<Widget> children;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? leading;
  final List<Widget>? actions;

  const FitTickStandardScreen({
    super.key,
    required this.topBarTitle,
    required this.pageTitle,
    required this.children,
    this.pageTitleButtons,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: leading,
        title: Text(topBarTitle),
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pageTitle, style: theme.textTheme.headlineSmall),
                if (pageTitleButtons != null) pageTitleButtons!,
              ],
            ),
            const Divider(height: 32.0),
            Expanded(
              // Wrap children in a Column in case there are multiple
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }
}
