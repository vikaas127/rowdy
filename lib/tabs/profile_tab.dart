import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/widgets/app_section_card.dart';
import 'package:dating_app/widgets/profile_basic_info_card.dart';
import 'package:dating_app/widgets/profile_statistics_card.dart';
import 'package:dating_app/widgets/delete_account_button.dart';
import 'package:dating_app/widgets/sign_out_button_card.dart';
import 'package:dating_app/widgets/vip_account_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatelessWidget {
  // Variables

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0.0),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, userModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Basic profile info
            ProfileBasicInfoCard(),
            SizedBox(height: 10),
            /// App Section Card
            AppSectionCard(),
            Divider(height: 0),
            SignOutButtonCard(),
            Divider(height: 0),
            /// Profile Statistics Card
            ProfileStatisticsCard(),
            Divider(height: 0),
            SizedBox(height: 10),
            /// Show VIP dialog
            VipAccountCard(),
            /// Delete Account Button
            DeleteAccountButton(),
            SizedBox(height: 25),

          ],
        );
      }),
    );
  }
}
