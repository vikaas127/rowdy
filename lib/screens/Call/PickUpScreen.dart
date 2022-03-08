import 'package:dating_app/screens/Call/AgoraVideoCallScreen.dart';
import 'package:dating_app/screens/Call/AgoraVoiceCallScreen.dart';
import 'package:dating_app/screens/Call/utilites/AppColors.dart';
import 'package:dating_app/screens/Call/utilites/AppConstants.dart';
import 'package:dating_app/screens/Call/utilites/Appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'components/Permissions.dart';
import 'localDB/LogRepository.dart';
import 'models/CallModel.dart';
import 'models/LogModel.dart';

class PickUpScreen extends StatefulWidget {
  final CallModel? callModel;

  PickUpScreen({this.callModel});

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  bool isCalledMissed = true;

  addToLocalStorage({String? status}) {
    LogModel callLog = LogModel(
      callerName: widget.callModel!.callerName,
      callerPic: widget.callModel!.callerPhotoUrl,
      callStatus: status,
      receiverName: widget.callModel!.receiverName,
      receiverPic: widget.callModel!.receiverPhotoUrl,
      timestamp: DateTime.now().toString(),
    );

    LogRepository.addLogs(callLog);
  }

  @override
  void dispose() {
    if (isCalledMissed) {
      addToLocalStorage(status: CALLED_STATUS_MISSED);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: context.height(),
          child: Stack(
            children: [
              Container(color: Colors.black54),
              Container(
                height: context.height() * 0.30,
                color: primaryColor,
                width: context.width(),
                child: Column(
                  children: [
                    4.height,

                    20.height,
                    Stack(
                      children: [
                        cachedImage(
                          widget.callModel!.callerPhotoUrl,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          radius: 80,
                        ).cornerRadiusWithClipRRect(80),
                        Positioned(
                          bottom: 6,
                          right: 0,
                          child: Image.asset("assets/app_icon.png", height: 25, width: 25),
                        )
                      ],
                    ),
                    16.height,
                    Text(widget.callModel!.callerName.validate(), style: primaryTextStyle(color: Colors.white, size: 25)),
                    20.height,
                    Text('Incoming'.toUpperCase(), style: secondaryTextStyle(size: 16, color: Colors.white60)),
                  ],
                ),
              ),
              /*  Image.asset("assets/user.png").paddingTop(context.height() * 0.40),*/
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(Icons.call_end, color: Colors.redAccent),
                        onPressed: () async {
                          isCalledMissed = false;
                          setState(() {});
                          addToLocalStorage(status: CALLED_STATUS_RECEIVED);
                          await callService.endCall(callModel: widget.callModel!);
                        },
                      ),
                    ),
                    6.width,
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(Icons.call, color: Colors.green),
                        onPressed: () async {
                          addToLocalStorage(status: CALLED_STATUS_RECEIVED);
                          isCalledMissed = false;
                          setState(() {});

                          if (widget.callModel!.isVoice!) {
                            await Permissions.cameraAndMicrophonePermissionsGranted() ? AgoraVoiceCallScreen(callModel: widget.callModel).launch(context) : {};
                          } else {
                            await Permissions.cameraAndMicrophonePermissionsGranted() ? AgoraVideoCallScreen(callModel: widget.callModel).launch(context) : {};
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
