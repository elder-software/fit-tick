import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatefulWidget {
  final String label;
  final int initialValue;
  final ValueChanged<int> onChanged;
  final Color? color;

  const Counter({
    super.key,
    this.label = 'Amount',
    this.initialValue = 1,
    required this.onChanged,
    this.color,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _count;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
    _controller = TextEditingController(text: '$_count');
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _updateCountFromTextField();
    }
  }

  void _updateCount(int newCount) {
    final clampedCount = newCount < 1 ? 1 : newCount;
    if (_count != clampedCount) {
      setState(() {
        _count = clampedCount;
        widget.onChanged(_count);
        _controller.text = '$_count';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      });
    } else {
      _controller.text = '$_count';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  void _updateCountFromTextField() {
    final text = _controller.text;
    final value = int.tryParse(text);
    if (value != null) {
      _updateCount(value);
    } else {
      _controller.text = '$_count';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  void _increment() {
    _updateCount(_count + 1);
  }

  void _decrement() {
    if (_count > 1) {
      _updateCount(_count - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.color ?? theme.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: theme.textTheme.labelMedium),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIconButton(Icons.remove, _decrement, color),
              SizedBox(
                width: 40,
                height: 30,
                child: Center(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall?.copyWith(color: color),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    onSubmitted: (value) => _updateCountFromTextField(),
                    onTapOutside: (event) {
                      _focusNode.unfocus();
                    },
                  ),
                ),
              ),
              _buildIconButton(Icons.add, _increment, color),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed, Color color) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      splashRadius: 20,
      visualDensity: VisualDensity.compact,
    );
  }
}
