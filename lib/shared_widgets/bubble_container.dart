import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BubbleContainer extends StatelessWidget {
  final String position;
  final Widget? icon;
  final String? imageUrl;
  final List<Widget> children;

  const BubbleContainer(
      {super.key,
      required this.children,
      required this.position,
      this.icon,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: imageUrl != null
                ? Theme.of(context).colorScheme.dark
                : Theme.of(context).colorScheme.lightPink,
            image: imageUrl != null
                ? DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage(imageUrl!),
                    fit: BoxFit.cover)
                : null,
            borderRadius: position == 'START'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                  )
                : position == 'END'
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(0),
                      ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: children,
            ),
          ),
        ),
        icon != null
            ? Positioned(
                left: 30,
                top: -20,
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.darkPink,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: icon,
                    ))),
              )
            : const SizedBox()
      ],
    );
  }
}
