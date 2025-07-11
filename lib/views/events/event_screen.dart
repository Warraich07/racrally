import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/utils/custom_dialog.dart';
import 'package:racrally/views/events/widgets/create_event_bottom_sheet.dart';
import 'package:racrally/views/events/widgets/custom_card.dart';


import '../../app_theme/app_theme.dart';
import '../../constants/app_icons.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool showPassword=true;
  String? selectedFirstReminder;
  FocusNode focusNodePassword=FocusNode();
  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FloatingActionButton(
          backgroundColor: AppTheme.secondaryColor,
          onPressed: () {
            CreateEventSheet.show(context);
          },
          child: Icon(Icons.add,color: AppTheme.primaryColor,),
        ),
      ),

      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Management",style: AppTheme.mediumHeadingStyle,),
                Image.asset(AppIcons.event,height: 24,width: 24,)
              ],
            ),
            SizedBox().setHeight(10),
            CustomTextField(
              hintText: "Search here",
              prefixIcon: AppIcons.search,
              prefixIconColor: AppTheme.lightGreyColor,
            ),
            SizedBox().setHeight(15),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.eventDetail);
              },
              child: CustomCard(
                  title: "Annual Team Lunch",
                  dateTime: "Saturday, June 22 - 5:00 PM",
                  location: "Maplewood Park - Field 3",
                onDeleteTap: (){
                    CustomDialog.showDeleteDialog(
                      iconPath: AppIcons.delete
                    );
                },
              ),
            ),
            GestureDetector(
        
              onTap: (){
                Get.toNamed(AppRoutes.eventDetail);
              },
              child: CustomCard(
                isUpComing:null,
                title: "Annual Team Lunch",
                dateTime: "Saturday, June 22 - 5:00 PM",
                location: "Maplewood Park - Field 3",
                onDeleteTap: (){
                  CustomDialog.showDeleteDialog(
                      iconPath: AppIcons.delete
                  );
                },
              ),
            ),
        
          ],
        ).paddingOnly(left: 16,right: 16,top: 40),
      ),
    );
  }
}
