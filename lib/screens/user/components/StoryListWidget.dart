import 'package:flutter/material.dart';
import 'package:FmI/models/NewsData.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/utils/Colors.dart';
import 'package:FmI/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../StoryListScreen.dart';

class StoryListWidget extends StatelessWidget {
  static String tag = '/StoryListWidget';
  final List<NewsData>? list;
  final Color? backgroundColor;
  final Color? textColor;

  StoryListWidget({this.list, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    if (getBoolAsync(DISABLE_STORY_WIDGET)) return SizedBox();
    var h = 70.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        16.height,
        Container(
          height: h,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              children: list.validate().map((e) {
                return Container(
                  height: h,
                  width: h,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorPrimary, width: 1),
                    borderRadius: radius(50),
                  ),
                  child: cachedImage(e.image, fit: BoxFit.cover).cornerRadiusWithClipRRect(50),
                ).onTap(() {
                  StoryListScreen(list: list).launch(context);
                });
              }).toList(),
            ),
          ),
        ),
      ],
    ).visible(list.validate().isNotEmpty);
  }
}
