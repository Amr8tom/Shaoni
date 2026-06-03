import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/device/device_utility.dart';
import 'package:shaoni/features/navigation/presentation/widgets/custom_navigation_appbar.dart';
import 'package:shaoni/features/notifications/presentation/widget/mark_all_checkbox_widget.dart';
import 'package:shaoni/features/notifications/presentation/widget/notification_card.dart';
import '../../../common/dummay.dart';
import '../../../common/widgets/appbar/appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.scaffoldBG,
      appBar: DAppBar(
        showBackArrow: true,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const Sizer(height: 180),

          /// Mark all as read checkbox
          const MarkAllCheckboxWidget(),

          /// Notification list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
              itemCount: Dummy.notifications.length,
              itemBuilder: (context, index) {
                final notification = Dummy.notifications[index];
                final isExpanded = expandedIndex == index;

                return NotificationCard(
                  notification: notification,
                  isExpanded: isExpanded,
                  onTap: () {
                    setState(() {
                      if (expandedIndex == index) {
                        expandedIndex = null;
                      } else {
                        expandedIndex = index;
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
