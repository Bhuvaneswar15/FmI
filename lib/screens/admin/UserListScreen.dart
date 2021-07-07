import 'package:flutter/material.dart';
import 'package:FmI/AppLocalizations.dart';
import 'package:FmI/components/AppWidgets.dart';
import 'package:FmI/main.dart';
import 'package:FmI/models/UserModel.dart';
import 'package:FmI/screens/admin/components/UserItemWidget.dart';
import 'package:FmI/utils/Common.dart';
import 'package:FmI/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../main.dart';

class UserListScreen extends StatelessWidget {
  static String tag = '/UserListScreen';

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: appBarWidget('users'.translate, showBack: false),
      body: PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (index, context, documentSnapshot) {
          return UserItemWidget(UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>));
        },
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        // orderBy is compulsory to enable pagination
        query: userService.ref!.orderBy('updatedAt', descending: true),
        itemsPerPage: DocLimit,
        bottomLoader: Loader(),
        initialLoader: Loader(),
        emptyDisplay: noDataWidget(),
        onError: (e) => Text(e.toString(), style: primaryTextStyle()).center(),
      ),
    );
  }
}
