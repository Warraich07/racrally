// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:racrally/extensions/height_extension.dart';
// import 'package:racrally/extensions/width_extension.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../app_theme/app_theme.dart';
// import '../../app_widgets/custom_button.dart';
// import '../../constants/app_icons.dart';
// import '../events/widgets/custom_card_attendees.dart';
//
// class TeamDetailsScreen extends StatefulWidget {
//   const TeamDetailsScreen({super.key});
//
//   @override
//   State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
// }
//
// class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.primaryColor,
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 25.h,
//             decoration: BoxDecoration(
//               color: AppTheme.primaryDarkColor,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(24),
//                 bottomRight: Radius.circular(24),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                         onTap: (){
//                           Get.back();
//                         },
//                         child: Image.asset(AppIcons.back_arrow,width: 24,)),
//                     Theme(
//                       data: Theme.of(context).copyWith(
//                         popupMenuTheme: PopupMenuThemeData(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       child: PopupMenuButton<String>(
//                         color: AppTheme.primaryColor,
//                         itemBuilder: (context) => [
//                           PopupMenuItem(
//                             value: 'edit',
//                             child: Row(
//                               children: [
//                                 Image.asset(AppIcons.edit, height: 20, width: 20),
//                                 const SizedBox(width: 10),
//                                 Text('Edit', style: AppTheme.bodyMediumGreyStyle),
//                               ],
//                             ),
//                           ),
//                           PopupMenuItem(
//                             value: 'delete',
//                             child: Row(
//                               children: [
//                                 Image.asset(AppIcons.delete, height: 20, width: 20),
//                                 const SizedBox(width: 10),
//                                 Text('Delete', style: AppTheme.bodyMediumGreyStyle),
//                               ],
//                             ),
//                           ),
//                         ],
//                         onSelected: (value) {
//                           if (value == 'edit') {
//                             // onEditTap?.call();
//                           } else if (value == 'delete') {
//                             // onDeleteTap?.call();
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 Center(child: Text("Annual Team Session",style: AppTheme.mediumHeadingFont600Style,)),
//                 SizedBox().setHeight(10)
//               ],
//             ).paddingOnly(top: 40,left: 16),
//           ),
//           Column(
//             children: [
//               CustomButton(
//                   onTap: (){
//                     // RSVPSheet.show(context);
//                   },
//                   Text: "Invite Member"),
//               SizedBox().setHeight(15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Team Members",style: AppTheme.mediumHeadingStyle,),
//                   Row(
//                     children: [
//                       Row(
//                         children: [ Image.asset(AppIcons.accepted,height: 18,width: 18,),const SizedBox().setWidth(3),Text("12",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
//                       ),
//                       const SizedBox().setWidth(5),
//                       Row(
//                         children: [ Image.asset(AppIcons.cancelled,height: 18,width: 18,),const SizedBox().setWidth(3),Text("05",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox().setHeight(10),
//               SizedBox(
//                 // height: 38.h,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CustomCardAttendees(name: 'Noraiz Shahid', details: 'noraizshahid@gmail.com',isAttending:null),
//                       CustomCardAttendees(name: 'Talha', details: 'talha12@gmail.com',isAttending:true),
//                       CustomCardAttendees(name: 'Umer', details: 'umer12@gmail.com',isAttending:false),
//                       CustomCardAttendees(name: 'Umer', details: 'umer12@gmail.com',isAttending:false),
//                     ],
//                   ),
//                 ),
//               ),
//
//
//
//             ],
//           ).paddingSymmetric(horizontal: 16,vertical: 16)
//         ],
//       ),
//     );
//   }
// }
