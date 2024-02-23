import 'package:dental_house/models/teeth_part.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:svg_drawing_animation/svg_drawing_animation.dart';
import 'package:touchable/touchable.dart';

import '../../models/adult_painter.dart';
import 'package:path_drawing/path_drawing.dart';


class NotificationsList extends StatefulWidget {
  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
@override
Widget build(BuildContext context) {
  return Consumer<EventProvider>(builder: (context,model,child){
    model.loadSvgImage(svgImage: 'images/chart.svg');
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            print('tap');
          },

        ),
      )
          );
});
}
}




