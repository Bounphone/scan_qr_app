import 'package:flutter_blueprint/packages.dart';

class ImageSlidePanel extends StatelessWidget {
  int index;
  ImageSlidePanel({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVM>(builder: (context, model, _) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFffffff),
        ),
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                model.getDynamicMenuPanels[index]!.title ?? '',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
            ),
            ImageSlideshow(
              width: double.infinity,
              height: 150.h,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              autoPlayInterval: 5000,
              isLoop: model.getDynamicMenuPanels[index]!.items!.length <= 1
                  ? false
                  : true,
              children: model.getDynamicMenuPanels[index]!.items!
                  .map((e) => GestureDetector(
                        onTap: () async {
                          if (e.isHasBehavior ?? false) {
                            await DynamicMenuValidate.onPressedPanel(
                                e.behaviorType!.navigationType,
                                context,
                                e.behaviorType!.url!,
                                e.title ?? '');
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          elevation: 3,
                          child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 15.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  // image: DecorationImage(
                                  //     image: NetworkImage(background ?? ''),
                                  //     fit: BoxFit.fill
                                  // ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF99D8FA),
                                        Color(0xFF579DFC)
                                      ])),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      imageUrl: e!.background ?? '',
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          SizedBox(),
                                      // errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 13.h,
                                                    ),
                                                    e.label == ''
                                                        ? SizedBox()
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(12
                                                                            .r)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6.w,
                                                                    vertical:
                                                                        4.h),
                                                            child: Text(
                                                              e.label ?? '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            )),
                                                    SizedBox(
                                                      height: 6.h,
                                                    ),
                                                    Text(
                                                      e.title ?? '',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                              0xFFFFFFFF)),
                                                    ),
                                                    SizedBox(
                                                      height: 6.h,
                                                    ),
                                                    Text(
                                                      e.subTitle ?? '',
                                                      style: TextStyle(
                                                          fontSize: 12.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100.w,
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          right: 18.w,
                                          bottom: 0,
                                          // top: 0,
                                          // left: 0,
                                          child: CachedNetworkImage(
                                            width: 83.w,
                                            height: 83.h,
                                            imageUrl: e.icon ?? '',
                                            placeholder: (context, url) =>
                                                const Center(child: Text('')),
                                            errorWidget:
                                                (context, url, error) =>
                                                    SizedBox(),
                                            // errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
