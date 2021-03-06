import 'package:FmI/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/models/WeatherResponse.dart';
import 'package:FmI/network/RestApis.dart';
import 'package:FmI/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class WeatherWidget extends StatelessWidget {
  static String tag = '/WeatherWidget';

   Future<void> init() async {
    getAppBarWidgetTextColor();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherResponse>(
      future: weatherMemoizer.runOnce(() => getWeatherApi()),
      builder: (_, snap) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: colorPrimary, blurRadius: 0.6, spreadRadius: 1.0),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snap.hasData ? snap.data!.location!.name.validate() : '-',
                    style: boldTextStyle(size: 28 , color: white),
                    overflow: TextOverflow.ellipsis,
                  ).paddingLeft(8),
                  4.height,
                  Text(
                    'news_feed'.translate,
                    style: secondaryTextStyle(color: white),
                  ).paddingLeft(8),
                ],
              ).expand(),
              Row(
                children: [
                  snap.hasData
                      ? cachedImage(
                          'https:${snap.data!.current!.condition?.icon?.validate()}',
                          height: 50,
                          usePlaceholderIfUrlEmpty: false,
                        ).paddingRight(8)
                      : SizedBox(),
                  Text(
                    (snap.hasData ? '${snap.data!.current!.temp_c.validate().toInt().toString()}??' : '-'),
                    style: boldTextStyle(size: 30, color: white),
                  ).paddingRight(8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
