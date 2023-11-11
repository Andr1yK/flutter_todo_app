import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.disabled = false,
  });

  final String text;
  final void Function() onPressed;
  final bool isSelected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    var secondaryColor = Theme.of(context).colorScheme.secondary;

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (Set<MaterialState> states) {
            if (isSelected || states.contains(MaterialState.hovered)) {
              return const RoundedRectangleBorder(
                side: BorderSide(
                  color: Color.fromRGBO(175, 47, 47, 0.2),
                ),
              );
            }
            return const RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(230, 230, 230, 0),
              ),
            );
          },
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: disabled ? Colors.grey : secondaryColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}