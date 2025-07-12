import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../core/constants/color/app_colors.dart';
import '../../core/constants/strings/app_strings.dart';

class CommonListView<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T item) itemBuilder;
  final EdgeInsetsGeometry? padding;

  const CommonListView({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            TextWidgets.textWidget(
                AppStrings.noDataText, AppColors.cblackColor,
                fontSize: 14),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => itemBuilder(data[index]),
    );
  }
}
