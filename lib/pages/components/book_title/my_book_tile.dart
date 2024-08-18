import 'package:e_book/model/book.dart';
import 'package:e_book/pages/components/book_title/my_book_tite_item.dart';
import 'package:e_book/pages/components/book_title/my_book_tite_item_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookTile extends StatelessWidget {
  final List<Book>? books;
  final double? height;
  final double? width;
  final bool? showPrice;
  final Function(Book book)? itemTap;
  const MyBookTile({
    super.key,
    required this.books,
    this.height,
    this.width,
    this.showPrice = false,
    this.itemTap,
  });

  @override
  Widget build(BuildContext context) {
    // 特别为您准备
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '特别为您准备',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        15.verticalSpace,

        // 书籍信息
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(books?.length ?? 5, (index) {
              if (books == null) {
                // 骨架屏
                return MyBookTileItemSkeleton(
                  width: width ?? 120.w,
                  height: height ?? 160.h,
                );
              }
              return GestureDetector(
                onTap: () {
                  if (books?[index] == null) return;
                  itemTap?.call(books![index]);
                },
                child: MyBookTileItem(
                  book: books![index],
                  width: width ?? 120.w,
                  height: height ?? 160.h,
                  showPrice: showPrice,
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
