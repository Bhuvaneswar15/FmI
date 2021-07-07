import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:FmI/AppLocalizations.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/models/NewsData.dart';
import 'package:FmI/screens/admin/UploadNewsScreen.dart';
import 'package:FmI/screens/admin/components/NewsItemGridWidget.dart';
import 'package:FmI/utils/Common.dart';
import 'package:FmI/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class IndependentNewsGridWidget extends StatefulWidget {
  static String tag = '/IndependentNewsGridWidget';

  final String? newsType;
  final bool? showAppBar;

  final String filterBy;
  final DocumentReference? categoryRef;

  IndependentNewsGridWidget({this.newsType, this.showAppBar, this.filterBy = FilterByPost, this.categoryRef});

  @override
  _IndependentNewsGridWidgetState createState() => _IndependentNewsGridWidgetState();
}

class _IndependentNewsGridWidgetState extends State<IndependentNewsGridWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: widget.showAppBar.validate() ? appBarWidget('all_news'.translate) : null,
      body: Container(
        child: StreamBuilder<List<NewsData>>(
          stream: widget.filterBy == FilterByPost ? newsService.getNews(newsType: widget.newsType.validate()) : newsService.getNewsByCategory(widget.categoryRef),
          builder: (_, snap) {
            if (snap.hasData) {
              if (snap.data!.isEmpty) {
                return noDataWidget();
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 16,
                  runSpacing: 8,
                  children: snap.data.validate().map((e) {
                    return NewsItemGridWidget(
                      e,
                      onTap: () {
                        UploadNewsScreen(data: e).launch(context);
                      },
                    );
                  }).toList(),
                ),
              );
            } else {
              return snapWidgetHelper(snap);
            }
          },
        ),
      ),
    );
  }
}
