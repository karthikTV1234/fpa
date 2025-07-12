import 'package:flutter/material.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CustomListView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final record = data[index];
        return GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)),
              color: AppColors.cwhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                TextWidgets.textWidget(
                                  textAlign: TextAlign.left,
                                  record["category"] ?? "",
                                  AppColors.cblackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: record["statusColor"] ?? Colors.grey,
                                  ),
                                  child: TextWidgets.textWidget(
                                    record["status"] ?? "",
                                    AppColors.cblackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            TextWidgets.textWidget(
                              textAlign: TextAlign.left,
                              record["title"] ?? "",
                              AppColors.cblackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            TextWidgets.textWidget(
                              textAlign: TextAlign.left,
                              record["subtitle"] ?? "",
                              AppColors.cblackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,
                          color: AppColors.cblackColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
