import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ImgStickyButton extends StatefulWidget {

  final File imageFile;
  final void Function()? function;

  const ImgStickyButton(this.imageFile, this.function, {super.key});

  @override
  State<ImgStickyButton> createState() => _ImgStickyButtonState();
}

class _ImgStickyButtonState extends State<ImgStickyButton> {

  final GlobalKey _imgContainerKey = GlobalKey();

  double? _imgWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                key: _imgContainerKey,
                borderRadius: BorderRadius.circular(10),
                child: Image.file(widget.imageFile, frameBuilder: (context, child, int? frame, bool? wasSynchronouslyLoaded) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _getImageWidth();
                  });
                  return child;
                },)),
          ),
          _imgWidth != null && _imgWidth! > 0.0 ? _buildRemoveButton() : const SizedBox(width: 0, height: 0)
        ],
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
        left: _imgWidth!,
        child: InkWell(
            onTap: widget.function,
            child: const Icon(Icons.remove_circle, size: 30,)
        )
    );
  }

  void _getImageWidth() async {
    RenderBox renderBox = _imgContainerKey.currentContext!.findRenderObject() as RenderBox;
    _imgWidth = renderBox.size.width;
    setState(() {});
  }

}