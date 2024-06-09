import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomInput extends HookWidget {
  final String label;
  final TextEditingController textController;
  final bool? obscureText;

  const CustomInput(
      {super.key,
      required this.label,
      required this.textController,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 60,
        child: TextFormField(
          controller: textController,
          onChanged: (value) {},
          autofocus: true,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.dark),
            labelText: label,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.dark),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0F2F1),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0F2F1),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            suffixIcon: InkWell(
              onTap: () async {
                textController.clear();
              },
              child: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.dark,
                size: 22,
              ),
            ),
          ),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.dark,
              ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
