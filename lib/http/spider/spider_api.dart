import 'package:dio/dio.dart';
import 'package:e_book/http/dio_instance.dart';
import 'package:e_book/http/spider/api_string.dart';
import 'package:e_book/model/activity.dart';
import 'package:e_book/model/book.dart';
import 'package:e_book/model/types.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class SpiderApi {
  static SpiderApi? _instance;

  SpiderApi._();

  static SpiderApi instance() {
    return _instance ??= SpiderApi._();
  }

  ///解析豆瓣商场首页数据
  void fetchDoubanStoreData(
      {Function(List<Book> values)? weeklyBooksCallback,
      Function(List<Book> values)? top250BooksCallback}) async {
    String html = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);
    Document doc = parse(html);

    if (weeklyBooksCallback != null) {
      weeklyBooksCallback.call(_parseWeeklyBooks(doc));
    }
    if (top250BooksCallback != null) {
      top250BooksCallback.call(_parseTop250Books(doc));
    }
  }

  ///获取豆瓣商城新书速递
  Future<List<Book>> fetchExpressBooks() async {
    Response res = await DioInstance.instance().get(
        path: ApiString.bookExpressJsonUrl,
        param: {"tag": BookExpressTag.all.value});
    Document doc = parse(res.data['result']);
    return _parseExpressBooks(doc);
  }

  ///获取图书活动
  Future<List<Activity>> fetchBookActivities(int? kind) async {
    Map<String, dynamic>? param = kind == null ? null : {"kind": kind};
    Response res = await DioInstance.instance()
        .get(path: ApiString.bookActivitiesJsonUrl, param: param);
    String htmlStr = res.data['result'];
    Document doc = parse(htmlStr);
    return parseBookActivities(doc);
  }

  ///获取首页数据
  Future fetchHomeData({
    Function(List<Activity> values)? activitiesCallback,
    Function(List<String> values)? activityLabelsCallback,
    Function(List<Book> values)? booksCallback,
  }) async {
    String htmlStr = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);
    Document doc = parse(htmlStr);

    //解析活动数据
    if (activitiesCallback != null) {
      activitiesCallback.call(parseBookActivities(doc));
    }
    //解析所有活动标签数据
    if (activityLabelsCallback != null) {
      List<Element> spanEls =
          doc.querySelectorAll('.books-activities .hd .tags .item');
      List<String> labels = [];
      for (Element span in spanEls) {
        labels.add(span.text.trim());
      }
      activityLabelsCallback.call(labels);
    }

    //解析书籍
    if (booksCallback != null) {
      booksCallback.call(_parseExpressBooks(doc));
    }
  }

  List<Activity> parseBookActivities(Document doc) {
    List<Element> aEls =
        doc.querySelectorAll('.books-activities .book-activity');
    List<Activity> activities = [];
    for (Element a in aEls) {
      String url = a.attributes['href']?.trim() ?? "";
      String cover = ApiString.getBookActivityCover(a.attributes['style']);
      String title = a.querySelector('.book-activity-title')?.text.trim() ?? "";
      String label = a.querySelector('.book-activity-label')?.text.trim() ?? "";
      String time =
          a.querySelector('.book-activity-time time')?.text.trim() ?? "";
      activities.add(Activity(
        url: url,
        cover: cover,
        title: title,
        label: label,
        time: time,
      ));
    }
    return activities;
  }

  ///解析首页书籍
  List<Book> _parseExpressBooks(Document doc) {
    List<Book> books = [];
    //只获取一页
    Element ulEl = doc.querySelectorAll('.books-express .bd .slide-item')[1];
    List<Element> liEls = ulEl.querySelectorAll('li');
    for (Element li in liEls) {
      Element? a = li.querySelector('.cover a');
      //解析ID
      String id = ApiString.getId(a?.attributes['href'], ApiString.bookIdReg);
      String cover = a?.querySelector('img')?.attributes['src'] ?? "";

      books.add(Book(
        id: id,
        cover: cover,
        title: li.querySelector('.info .title a')?.text.trim() ?? "",
        authorName: li.querySelector('.info .author')?.text.trim() ?? "",
      ));
    }
    return books;
  }

  List<Book> _parseWeeklyBooks(Document doc) {
    List<Element> liEls = doc.querySelectorAll(".popular-books .bd ul li");
    return liEls.map((li) {
      //封面
      String? cover = li.querySelector('.cover img')?.attributes['src'];
      //标题
      Element? aEl = li.querySelector(".title a");
      String? title = aEl?.innerHtml;
      String? id =
          ApiString.getId(aEl?.attributes['href'], ApiString.bookIdReg);
      //作者
      String? authorName = li.querySelector('.author')?.innerHtml.trim() ?? "";
      authorName = authorName.replaceFirst("作者：", "");
      //副标题
      String? subTitle;
      if (title != null && title.isNotEmpty) {
        List titles = title.split(':');
        if (titles.length > 1) {
          title = titles[0];
          subTitle = titles[1];
        } else {
          subTitle = authorName;
        }
      }
      //评分
      double rate = parseRate(li.querySelector(".average-rating")?.text.trim());
      return Book(
        id: id,
        cover: cover,
        title: title,
        subTitle: subTitle,
        authorName: authorName,
        rate: rate,
      );
    }).toList();
  }

  double parseRate(String? rateStr) {
    if (rateStr == null || rateStr.isEmpty) return 0.0;
    try {
      return double.parse(rateStr);
    } catch (_) {
      return 0.0;
    }
  }

  List<Book> _parseTop250Books(Document doc) {
    //class用. id用#
    List<Element> dlEls = doc.querySelectorAll("#book_rec dl");
    return dlEls.map((dl) {
      Element aEl = dl.children[0].children[0];
      String? cover = aEl.children[0].attributes['src'];
      String? id = ApiString.getId(aEl.attributes['href'], ApiString.bookIdReg);
      return Book(
          id: id, cover: cover, title: dl.children[1].children[0].text.trim());
    }).toList();
  }
}
