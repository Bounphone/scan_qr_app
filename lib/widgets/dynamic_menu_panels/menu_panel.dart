import 'package:flutter_blueprint/packages.dart';

class MenuPanel extends StatelessWidget {
  int index;
  MenuPanel({required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVM>(builder: (context, model, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text(
              model.getDynamicMenuPanels[index]!.title ?? '',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 4,
            children: model.getDynamicMenuPanels[index]!.items!
                .map((e) => InkWell(
                      onTap: () async {
                        if (e.isHasBehavior ?? false) {
                          await DynamicMenuValidate.onPressedPanel(
                              e.behaviorType!.navigationType,
                              context,
                              e.behaviorType!.url!,
                              e.title ?? '');
                        }
                      },
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            e!.icon == null
                                ? Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFC4C4C4)),
                                  )
                                : CachedNetworkImage(
                                    width: 40.w,
                                    height: 40.h,
                                    imageUrl: e.icon!,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              e.title ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      );
    });
  }
}
