import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_book/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookTileItem extends StatelessWidget {
  final Book book;
  final double? height;
  final double? width;
  final bool? showPrice;
  const MyBookTileItem(
      {super.key, required this.book, this.height, this.width, this.showPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              //封面
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(book.cover ?? "",
                            headers: const {
                              'User-Agent':
                                  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'
                            }),
                        fit: BoxFit.cover)),
              ),
              //价格
              _getPriceUI(context)
            ],
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10.h),
            width: width,
            child: Text(
              book.title ?? "", // 明确指定 text 参数
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //副标题
          Container(
            padding: EdgeInsets.only(top: 10.h),
            width: width,
            child: Text(
              book.authorName ?? "",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPriceUI(BuildContext context) {
    if (showPrice == false) {
      return const SizedBox();
    }
    return Positioned(
        bottom: height == null ? 20 : height! / 3,
        child: Container(
          width: 65.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
          ),
          child: Center(
            child: Text(
              '¥12.0',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
