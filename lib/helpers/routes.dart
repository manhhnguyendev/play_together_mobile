import 'package:flutter/widgets.dart';
import 'package:play_together_mobile/models/detail_hiring_model.dart';
import 'package:play_together_mobile/pages/hiring_negotiating_page.dart';
import 'package:play_together_mobile/pages/hiring_stage_page.dart';
import 'package:play_together_mobile/pages/history_hiring_detail_page.dart';
import 'package:play_together_mobile/pages/rating_comment_player_page.dart';
import 'package:play_together_mobile/pages/search_page.dart';
import 'package:play_together_mobile/pages/send_hiring_request_page.dart';
import 'package:play_together_mobile/pages/take_user_categories_page.dart';

final Map<String, WidgetBuilder> routes = {
  UserCategoriesPage.routeName: (context) => UserCategoriesPage(),
  SendHiringRequestPage.routeName: (context) => SendHiringRequestPage(),
  HiringNegotiatingPage.routeName: (context) => HiringNegotiatingPage(),
  RatingAndCommentPage.routeName: (context) => RatingAndCommentPage(),
  HiringPage.routeName: (context) => HiringPage(),
  SearchPage.routeName: (context) => SearchPage(),
  HistoryHiringDetail.routeName: (context) => HistoryHiringDetail(
        detailHiringModel: demoDetailHiring,
      ),
};
