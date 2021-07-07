import 'package:flutter/material.dart';
import 'package:FmI/AppLocalizations.dart';
import 'package:FmI/utils/Colors.dart';
import 'package:FmI/utils/Common.dart';
import 'package:FmI/utils/Constants.dart';
import 'package:FmI/utils/ModelKeys.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final bool? showTitle;

  LanguageSelectionWidget({this.showTitle});

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return SettingItemWidget(
      leading: language!.flag != null ? Image.asset(language!.flag!, height: 24) : null,
      title: showTitle.validate(value: true) ? 'language'.translate : '',
      subTitle: showTitle.validate(value: true) ? 'choose_app_language'.translate : null,
      onTap: () async {
        hideKeyboard(context);
      },
      trailing: DropdownButton(
        items: localeLanguageList.map((e) => DropdownMenuItem<LanguageDataModel>(child: Text(e.name!, style: primaryTextStyle(size: 14)), value: e)).toList(),
        dropdownColor: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white,
        value: language,
        underline: SizedBox(),
        onChanged: (LanguageDataModel? v) async {
          hideKeyboard(context);
          await appStore.setLanguage(v!.languageCode!, context: context);

          if (appStore.isLoggedIn) {
            userService.updateDocument({UserKeys.appLanguage: v.languageCode}, appStore.userId);
          }

          await 300.milliseconds.delay;
          LiveStream().emit(StreamUpdateDrawer, true);
        },
      ),
    );
  }
}
