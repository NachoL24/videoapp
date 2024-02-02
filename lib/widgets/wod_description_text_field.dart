import 'package:flutter/material.dart';

class WodDescriptionTextField extends StatelessWidget {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  WodDescriptionTextField({
    super.key
  });
  //todo: ver como guardar estos datos
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      minLines: 2,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'Add workout description...',
        filled: true, 
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}