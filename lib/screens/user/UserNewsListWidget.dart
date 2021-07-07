import 'package:flutter/material.dart';
import 'package:FmI/models/NewsData.dart';
import 'package:nb_utils/nb_utils.dart';

import 'NewsDetailListScreen.dart';
import 'UserNewsItemWidget.dart';

class UserNewsListWidget extends StatelessWidget {
  static String tag = '/UserNewsListWidget';
  final List<NewsData>? list;

  UserNewsListWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return UserNewsItemWidget(
          newsData: list![index],
          onTap: () {
            NewsDetailListScreen(list, index: index).launch(context);
          },
        );
      },
      itemCount: list!.length,
      shrinkWrap: true,
    );
  }
}
