import 'dart:async';

import 'package:e_book/http/spider/spider_api.dart';
import 'package:e_book/model/activity.dart';
import 'package:e_book/model/book.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  List<Activity>? _activities;
  List<String>? _activityLabels;
  List<Book>? _books;

  List<Activity>? get activities => _activities;
  List<String>? get activityLabels => _activityLabels;
  List<Book>? get books => _books;

  set activities(List<Activity>? activities) {
    _activities = activities;
    notifyListeners();
  }

  set activityLabels(List<String>? activityLabels) {
    _activityLabels = activityLabels;
    notifyListeners();
  }

  set books(List<Book>? books) {
    _books = books;
    notifyListeners();
  }

  Future getHomePageData() async {
    await SpiderApi.instance().fetchHomeData(
      activitiesCallback: (values) => activities = values,
      activityLabelsCallback: (values) => activityLabels = values,
      booksCallback: (values) => books = values,
    );
  }
}
