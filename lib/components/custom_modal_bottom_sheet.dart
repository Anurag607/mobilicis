import 'package:flutter/material.dart';

class CustomBottomModalSheet {
  static void customBottomModalSheet(
      BuildContext context, double height, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: Colors.grey.shade100,
      enableDrag: true,
      showDragHandle: false,
      builder: (context) {
        return Container(
          height: height,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.black.withOpacity(0.8),
                    size: 30,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}
