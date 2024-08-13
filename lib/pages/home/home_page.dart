import 'package:e_book/model/activity.dart';
import 'package:e_book/model/book.dart';
import 'package:e_book/pages/components/my_book_tile.dart';
import 'package:e_book/pages/components/my_search_tile.dart';
import 'package:e_book/pages/home/components/my_book_activities.dart';
import 'package:e_book/pages/home/components/my_book_activity_labels.dart';
import 'package:e_book/pages/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getBodyUI(),
    );
  }

  Widget _getBodyUI() {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  children: [
                    10.verticalSpace,
                    //头像
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "您好,张丛",
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.w600),
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage('images/avatar.png'),
                        )
                      ],
                    ),
                    15.verticalSpace,
                    //搜索
                    MySearchTile(
                      bookshelfTap: () {},
                    ),
                    //读书活动
                    30.verticalSpace,
                    Selector<HomeViewModel, List<Activity>?>(
                        builder: (context, List<Activity>? activities, child) {
                          if (activities == null) {
                            return const SizedBox();
                          }
                          return MyBookActivities(activities: activities);
                        },
                        selector: (_, viewModel) => viewModel.activities),
                    15.verticalSpace,
                    //活动类型
                    Selector<HomeViewModel, List<String>?>(
                        builder: (context, labels, child) {
                          if (labels == null) {
                            return const SizedBox();
                          }
                          return MyBookActivityLabels(labels: labels);
                        },
                        selector: (_, viewModel) => viewModel.activityLabels),
                    30.verticalSpace,
                    //特别为您准备
                    Selector<HomeViewModel, List<Book>?>(
                        builder: (context, books, child) {
                          if (books == null) {
                            return const SizedBox();
                          }
                          return MyBookTile(
                            books: books,
                            height: 160.h,
                            width: 120.w,
                          );
                        },
                        selector: (_, viewModel) => viewModel.books),
                  ],
                )));
      },
    );
  }
}
