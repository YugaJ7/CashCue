import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const TabButton(this.title, this.index, this.selectedIndex, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9C1FF) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF7041A3) : Colors.grey,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
