import 'package:flutter/material.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/models/NewsData.dart';
import 'package:FmI/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

class UserNewsItemWidget extends StatelessWidget {
  static String tag = '/UserNewsItemWidget';
  final NewsData? newsData;
  final Function? onTap;

  UserNewsItemWidget({this.newsData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cachedImage(newsData!.image.validate(), fit: BoxFit.cover, height: 95, width: 130).cornerRadiusWithClipRRect(defaultRadius),
          8.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parseHtmlString(newsData!.title.validate()),
                maxLines: 3,
                style: boldTextStyle(size: 14),
                overflow: TextOverflow.ellipsis,
              ),
              8.height,
              Row(
                children: [
                  Icon(Icons.access_time_rounded, size: 18, color: textSecondaryColor),
                  2.width,
                  if (newsData!.updatedAt != null) Text(newsData!.updatedAt!.timeAgo, maxLines: 1, style: secondaryTextStyle(size: 11)),
                  2.width,
                  Text('・', style: secondaryTextStyle()),
                  2.width,
                  Text(
                    '${(parseHtmlString(newsData!.content).calculateReadTime()).ceilToDouble().toInt()} ${'min_read'.translate}',
                    style: secondaryTextStyle(size: 11),
                  ),
                ],
              ),
            ],
          ).expand(),
        ],
      ),
    ).onTap(() {
      onTap?.call();
    });
  }
}
