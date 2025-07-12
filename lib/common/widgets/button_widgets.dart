import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ButtonWidgets {
  static Widget elevatedButton(String title, Color buttonColor, Color textColor,
      void Function()? onPressed,
      {double height = 20.0,
      double width = 25.0,
      double radius = 1.0,
      double fontSize = 10.0,
      double? elevation,
      FontWeight fontWeight = FontWeight.normal,
      Color? borderColor,
      double? btnPadding}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        minimumSize: Size(width, height),
        foregroundColor: textColor,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(btnPadding ?? 0.0),
        child: TextWidgets.textWidget(title, textColor,
            fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }

  static Widget elevatedButtonWithIcon(String title, Color textColor,
      Color backgroundColor, VoidCallback onPressed, Widget icon, double radius,
      {double fontSize = 10.0,
      FontWeight fontWeight = FontWeight.normal,
      double iconsize = 14,
      double width = 0.0,
      double height = 0.0,
      double padding = 0.0,
      Color? borderColor,
      double borderWidth = 0.0}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: borderColor ?? Colors.transparent, width: borderWidth),
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.all(padding)),
      onPressed: () => onPressed(),
      icon: icon,
      label: TextWidgets.textWidget(title, textColor,
          fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  static Widget textButton(
      String title, Color textColor, VoidCallback onPressed,
      {double fontSize = 10.0,
      FontWeight fontWeight = FontWeight.normal,
      TextDecoration? decoration,
      Color? decorationColor}) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      onPressed: onPressed,
      child: TextWidgets.textWidget(title, textColor,
          fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  static Widget textButtonWithIconWidget(String title, Color textColor,
      VoidCallback onPressed, IconData icon, Color iconColor,
      {double fontSize = 10.0,
      FontWeight fontWeight = FontWeight.normal,
      double iconSize = 14}) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      label: TextWidgets.textWidget(title, textColor,
          fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  static Widget floatingActionButton(
      IconData icon, Color iconColor, Color bgColor, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Icon(icon, color: iconColor),
    );
  }

  static Widget getIconButton(Icon icon, VoidCallback onPressed,
      {double? iconSize}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
    );
  }

  static Widget addNewPlusCircle(
      IconData icon,
      Color iconColor, {
        double width = 30,
        double height = 30,
        double iconSize = 16,
      }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: iconColor, width: 1.5),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }

  static Widget addNewOutlinedButton({
    required Widget addNewPlusCircle,
    required String text,
    required Color iconColor,
    required VoidCallback onPressed,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: iconColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          spacing: 30,
          mainAxisSize: MainAxisSize.max,
          children: [
            addNewPlusCircle,
            TextWidgets.textWidget(
              text,
              iconColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ],
        ),
      ),
    );
  }
}
