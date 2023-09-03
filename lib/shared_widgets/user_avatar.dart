import 'package:coupler_app/constants.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;

  const UserAvatar({super.key, required this.imageUrl, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl ?? Constants().defaultAvatar,
        width: size ?? 30,
        height: size ?? 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
