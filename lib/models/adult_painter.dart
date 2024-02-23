
import 'package:dental_house/models/teeth_part.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:touchable/touchable.dart';

class AdultPainter extends CustomPainter {
  final BuildContext context;
  final EventProvider model;
  final String svg;
  final String id;

  AdultPainter({
    required this.context,
    required this.model,
    required this.svg,
    required this.id
  });
  @override
  void paint(Canvas canvas, Size size) {
    model.loadSvgImage(svgImage: svg);
     model.myCanvas = TouchyCanvas(context, canvas);
     model.paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;
    var xScale = size.width / 450;
    var yScale = size.height / 800;
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(xScale, yScale);
    model.paint2 = Paint()
    ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    List<GeneralBodyPart> generalParts = model.teethPart;

    generalParts.forEach((muscle) {
      Path path = parseSvgPath(muscle.path);
      model.paint.color = Colors.blue;
      model.paint2.color = Colors.black;
      if (model.selectedTeethPart.contains(muscle.name)) {
        model.paint.color = Colors.grey;
        model.paint2.color = Colors.red;
      }else{
      }
      model.myCanvas.drawPath(
        path.transform(matrix4.storage),
        model.paint,
        onTapDown: (details) {
         // addTeeth(id, muscle.name);
        },
      );
      model.myCanvas.drawPath(
        path.transform(matrix4.storage),
        model.paint2,
        onTapDown: (details) {
          // addTeeth(id, muscle.name);
          model.selectTeethPart(muscle.name);
        },
      );
    }
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
