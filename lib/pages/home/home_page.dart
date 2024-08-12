import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/pages/components/my_book_tile.dart';
import 'package:e_book/pages/components/my_search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 0;
  List<String> activities = ["全部", "读书专题", "直播活动", "名家问答", "共读交流", "鉴书团"];
  List<String> images = [
    'https://img3.doubanio.com/mpic/book-activity-fa7d714bf3804056b5234ee71a9a9d13',
    'https://img3.doubanio.com/mpic/book-activity-5f72c3983c7545c1910cfd569c2c4a82',
    'https://img3.doubanio.com/mpic/book-activity-fa7d714bf3804056b5234ee71a9a9d13',
    'https://img3.doubanio.com/mpic/book-activity-5f72c3983c7545c1910cfd569c2c4a82',
  ];

  List<Map<String, dynamic>> books = [
    {
      "title": "食南之徒",
      "authorName": "作者：马伯庸",
      "cover": 'https://img3.doubanio.com/view/subject/s/public/s34823157.jpg'
    },
    {
      "title": "我们八月见",
      "authorName": "作者：[哥伦比亚]加西亚·马尔克斯",
      "cover": 'https://img1.doubanio.com/view/subject/s/public/s34797230.jpg'
    },
    {
      "title": "七个证人",
      "authorName": "作者：[日] 西村京太郎",
      "cover": 'https://img9.doubanio.com/view/subject/s/public/s34896035.jpg'
    },
    {
      "title": "早安，怪物",
      "authorName": "作者：凯瑟琳·吉尔迪纳",
      "cover": 'https://img3.doubanio.com/view/subject/s/public/s34798823.jpg'
    },
    {
      "title": "怪画谜案",
      "authorName": "作者：[日] 雨穴",
      "cover": 'https://img1.doubanio.com/view/subject/s/public/s34903230.jpg'
    },
    {
      "title": "猫鱼",
      "authorName": "作者：陈冲",
      "cover": 'https://img9.doubanio.com/view/subject/s/public/s34867425.jpg'
    },
    {
      "title": "我胆小如鼠",
      "authorName": "作者：余华",
      "cover": 'https://img1.doubanio.com/view/subject/s/public/s34905759.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getBodyUI(),
    );
  }

  Widget _getBodyUI() {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '读书活动',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    10.verticalSpace,
                    SizedBox(
                      height: 150.h,
                      width: double.infinity,
                      child: Swiper(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              //背景图
                              Container(
                                width: double.infinity,
                                height: 150.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            images[index],
                                            headers: const {
                                          'User-Agent':
                                              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'
                                        }))),
                              ),
                              //背景
                              Container(
                                width: double.infinity,
                                height: 150.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                              //文字
                              Container(
                                height: 150.h,
                                padding: EdgeInsets.all(15.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //标题
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      '眺望山峦，或宁是虚空：卡夫卡逝世百年纪念对谈 ｜ 阿乙x李双志x包慧怡',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //专题，时间
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5.r),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(4.r)),
                                          child: const Text(
                                            "直播活动",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        //时间
                                        10.horizontalSpace,
                                        const Text(
                                          '2024-06-18',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        pagination: SwiperPagination(
                            alignment: Alignment.bottomRight,
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.white.withOpacity(0.4),
                                activeColor: Colors.white,
                                size: 8.0,
                                activeSize: 10.0,
                                space: 2.0)),
                      ),
                    )
                  ],
                ),
                15.verticalSpace,
                //活动类型
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '活动类型',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                      5.verticalSpace,
                      Wrap(
                        children: List.generate(activities.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: ChoiceChip(
                              label: Text(activities[index]),
                              selected: _value == index,
                              onSelected: (value) {
                                setState(() {
                                  _value = index;
                                });
                              },
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                30.verticalSpace,
                //特别为您准备
                MyBookTile(
                  books: books,
                  height: 160.h,
                  width: 120.w,
                )
              ],
            )));
  }
}
