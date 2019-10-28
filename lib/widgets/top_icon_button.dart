import 'package:flutter/material.dart';

import '../constants.dart';

class TopIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  const TopIconButton({
    @required this.icon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        icon,
        size: kTopIconSize,
      ),
      onTap: onPress,
    );
  }
}
