import 'package:flutter/material.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/models/CategoryData.dart';
import 'package:FmI/screens/user/ViewAllNewsScreen.dart';
import 'package:FmI/shimmer/TopicShimmer.dart';
import 'package:FmI/utils/Common.dart';
import 'package:FmI/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class UserCategoryFragment extends StatelessWidget {
  static String tag = '/UserCategoryFragment';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CategoryData>>(
        future: categoryService.categoriesFuture(),
        builder: (_, snap) {
          if (snap.hasData) {
            if (snap.data!.isEmpty) return noDataWidget();

            return SingleChildScrollView( 
              padding: EdgeInsets.all(16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.height,
                  Text('categories'.translate, style: boldTextStyle(size: 20)),
                  16.height,
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: MediaQuery.of(context).size.height * 0.017,
                    spacing: MediaQuery.of(context).size.width * 0.037,
                    children: snap.data!.map((e) {
                      return Container(
                        // padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width:MediaQuery.of(context).size.width * 0.437 ,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            cachedImage(e.image, height: 100, width: double.infinity, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius),
                            6.height,
                            Positioned(
                              bottom: 6,
                              left: 6,
                              child: Text(
                                e.name!,
                                style: boldTextStyle(color: Colors.white, size: 12, backgroundColor: Colors.black38),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).fit(),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        ViewAllNewsScreen(title: e.name, filterBy: FilterByCategory, categoryRef: categoryService.ref!.doc(e.id)).launch(context);
                      });
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return snapWidgetHelper(snap, loadingWidget: TopicShimmer());
          }
        },
      ),
    );
  }
}
