 import 'package:flutter/material.dart';

Color getColorFromCode(String colorCode) {
  if (colorCode.length == 7 && colorCode.startsWith('#')) {
    try {
      int red = int.parse(colorCode.substring(1, 3), radix: 16);
      int green = int.parse(colorCode.substring(3, 5), radix: 16);
      int blue = int.parse(colorCode.substring(5, 7), radix: 16);

      return Color.fromARGB(255, red, green, blue);
    } catch (e) {
     
    }
  } else {
   
  }

  // Return a default color if the input is invalid
  return Colors.black;
}

List<TextStyleValues> convertJsonToTextStyle(String json,
    {String cardArea = "#F85800,#285830,cookie-0,elsie-0,995,720,370,140"}) {
  List<String> cardAreaValues = cardArea.split(',');

  Color color1 = getColorFromCode(cardAreaValues[0]);
  Color color2 = getColorFromCode(cardAreaValues[1]);
  List<String> font1 = cardAreaValues[2].split('-');
  List<String> font2 = cardAreaValues[3].split('-');


  List<String> jsonEntries = json.split('=');
  List<TextStyleValues> result = [];

  for (String entry in jsonEntries) {
    List<String> values = entry.split(',');
    String fontFamily = "DefaultFont";
    Color color = Colors.black;
    double fontSize;
    double originalTop;
    double originalLeft;

    if (values.length >= 5) {
      if (values[0] == 'font1') {
        fontFamily = font1[0];
      } else if (values[0] == 'font2') {
        fontFamily = font2[0];
      }

      if (values[2] == 'color1') {
        color = color1;
      } else if (values[2] == 'color2') {
        color = color2;
      }

      fontSize = double.parse(values[1]);

      originalTop =
          double.parse(values[3]);
      originalLeft = double.parse(values[4]);
    } else {
      fontFamily = 'DefaultFont';
      color = Colors.black;
      fontSize = 16.0;
      originalTop = 0.0;
      originalLeft = 0.0;
    }

    TextStyle textStyle = TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
    );

    result.add(
      TextStyleValues(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        originalTop: originalTop,
        originalLeft: originalLeft,
        textStyle: textStyle,
      ),
    );
  }

  return result;
}

class TextStyleValues {
  String fontFamily;
  Color color;
  double fontSize;
  double originalTop;
  double originalLeft;
  TextStyle textStyle;

  TextStyleValues({
    required this.fontFamily,
    required this.color,
    required this.fontSize,
    required this.originalTop,
    required this.originalLeft,
    required this.textStyle,
  });
}

class TextStyleParser {
  static List<String> contentConverter(String json) {
    List<String> contentList = json.split(',');
    return contentList;
  }

  static List<TextStyleValues> parseTextStyle(String textStyleString) {

    List<String> textStyleList = textStyleString.split('=');
    List<TextStyleValues> result = [];
    for (String style in textStyleList) {
      List<String> textStyleValues = style.split(',');

      if (textStyleValues.length > 6) {
        try {
          String fontFamily = textStyleValues[0];
          Color color = getColorFromCode(textStyleValues[2]);
          double fontSize = double.parse(textStyleValues[1]);
          double originalTop = double.parse(textStyleValues[3]);
          double originalLeft = double.parse(textStyleValues[4]);

          TextStyle textStyle = getTextStyle(int.parse(textStyleValues[6]));

          result.add(TextStyleValues(
            fontFamily: fontFamily,
            color: color,
            fontSize: fontSize,
            originalTop: originalTop,
            originalLeft: originalLeft,
            textStyle: textStyle,
          ));
        } catch (e) {
        
        }
      } else {
     }
    }

    return result;
  }

  static TextStyleValues scaleValues(TextStyleValues values) {
    double heightScalingFactor = 430 / 1500;
    double widthScalingFactor = 290 / 1000;

    double scaledTop = values.originalTop * heightScalingFactor;
    double scaledLeft = values.originalLeft * widthScalingFactor;
    double scaledFontSize = values.fontSize * widthScalingFactor;
 
    return TextStyleValues(
      fontFamily: values.fontFamily,
      color: values.color,
      fontSize: scaledFontSize,
      originalTop: scaledTop,
      originalLeft: scaledLeft,
      textStyle: values.textStyle,
    );
  }
}

TextStyle getTextStyle(int styleIndex) {
  FontStyle fontStyle;
  FontWeight fontWeight;
  TextDecoration textDecoration;

  switch (styleIndex) {
    case 0:
      fontStyle = FontStyle.normal;
      fontWeight = FontWeight.normal;
      textDecoration = TextDecoration.none;
      break;
    case 1:
      fontStyle = FontStyle.normal;
      fontWeight = FontWeight.bold;
      textDecoration = TextDecoration.none;
      break;
    case 2:
      fontStyle = FontStyle.italic;
      fontWeight = FontWeight.normal;
      textDecoration = TextDecoration.none;
      break;
    case 3:
      fontStyle = FontStyle.italic;
      fontWeight = FontWeight.bold;
      textDecoration = TextDecoration.none;
      break;
    case 4:
      fontStyle = FontStyle.normal;
      fontWeight = FontWeight.normal;
      textDecoration = TextDecoration.underline;
      break;
    case 5:
      fontStyle = FontStyle.normal;
      fontWeight = FontWeight.bold;
      textDecoration = TextDecoration.underline;
      break;
    case 6:
      fontStyle = FontStyle.italic;
      fontWeight = FontWeight.normal;
      textDecoration = TextDecoration.underline;
      break;
    case 7:
      fontStyle = FontStyle.italic;
      fontWeight = FontWeight.bold;
      textDecoration = TextDecoration.underline;
      break;
    default:
      fontStyle = FontStyle.normal;
      fontWeight = FontWeight.normal;
      textDecoration = TextDecoration.none;
  }

  return TextStyle(
    fontStyle: fontStyle,
    fontWeight: fontWeight,
    decoration: textDecoration,
  );
}

Color convertHexToColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  int red = int.parse(hexColor.substring(0, 2), radix: 16);
  int green = int.parse(hexColor.substring(2, 4), radix: 16);
  int blue = int.parse(hexColor.substring(4, 6), radix: 16);
  int alpha = 255;
  return Color.fromARGB(alpha, red, green, blue);
}
