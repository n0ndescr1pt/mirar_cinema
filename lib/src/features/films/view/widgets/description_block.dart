import 'package:flutter/material.dart';

class DescriptionBlock extends StatefulWidget {
  final String description;
  const DescriptionBlock({super.key, required this.description});

  @override
  State<DescriptionBlock> createState() => _DescriptionBlockState();
}

class _DescriptionBlockState extends State<DescriptionBlock> {
  bool _expandedDescription = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedDescription = !_expandedDescription;
        });
      },
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        firstChild: Text(
          widget.description,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        secondChild: Text(
          widget.description,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        crossFadeState: _expandedDescription
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
      ),
    );
  }
}
