import 'package:flutter_blueprint/packages.dart';

class ListMenuPanel extends StatelessWidget {
  int index;
  ListMenuPanel({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVM>(builder: (context, model, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.getDynamicMenuPanels[index]?.title ?? '',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            SizedBox(
              height: 17.h,
            ),
            for (var i in model.getDynamicMenuPanels[index]!.items!)
              GestureDetector(
                onTap: () async {
                  if (i.isHasBehavior ?? false) {
                    await DynamicMenuValidate.onPressedPanel(
                        i.behaviorType!.navigationType,
                        context,
                        i.behaviorType!.url!,
                        i.title ?? '');
                  }
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CachedNetworkImage(
                              width: 36.w,
                              height: 36.h,
                              imageUrl: i!.icon ?? '',
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            SizedBox(
                              width: 18.sp,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  i.title ?? '',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                Row(
                                  children: [
                                    Text(i.subTitle ?? '',
                                        style: TextStyle(fontSize: 14.sp)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              i.detail ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: Color(0xFF3352F3)),
                            ),
                            Text(i.subDetail ?? '',
                                style: TextStyle(fontSize: 14.sp))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}
