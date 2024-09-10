import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(FontAwesomeIcons.chevronLeft),
          ),

          const Spacer(),
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(FontAwesomeIcons.message),
          ),

          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(FontAwesomeIcons.headphones),
          ),

          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(FontAwesomeIcons.shareFromSquare),
          ),
    
        ],
      ),
    );
  }
}