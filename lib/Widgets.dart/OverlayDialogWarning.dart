// ignore_for_file: file_names
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'VVGradientButton.dart';

enum DialogType {
  Success,
  Warning,
}

// ignore: must_be_immutable
class OverlayDialogWarning extends StatefulWidget {
  /// @required message
  String message = "";

  /// isBack default value false
  final bool isBack;

  /// showButton default value false
  final bool showButton;

  /// DialogType dialogType = Default is Success
  DialogType dialogType;
  // @optionalTypeArgs
  // bool isSuccess = false;
  OverlayDialogWarning({
    @required this.message,
    this.isBack = false,
    this.showButton = false,
    this.dialogType = DialogType.Success,
    // @optionalTypeArgs this.isSuccess
  });

  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return OverlayDialogWarningState();
  }
}

class OverlayDialogWarningState extends State<OverlayDialogWarning>
    with SingleTickerProviderStateMixin {
  Animation<double> scaleAnimation;
  AnimationController controller;
  // bool isSuccess = true;
  // Temp Comment

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    scaleAnimation = CurvedAnimation(
        parent: controller, curve: Curves.elasticInOut); //elasticInOut
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    if (widget.showButton == false) {
      Future.delayed(Duration(milliseconds: 2000), () {
        setState(() {
          Navigator.pop(context, true);
          if (widget.isBack != null && widget.isBack) {
            Navigator.pop(context, true);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // BackdropFilter blurry filter
    // https://stackoverflow.com/questions/43550853/how-do-i-do-the-frosted-glass-effect-in-flutter
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            // margin: EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 50,
                      child: widget.dialogType == DialogType.Success
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 40,
                            )
                          : Image.asset('images/axon.png', fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      widget.message,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  (widget.showButton)
                      ? VVGradientButton(
                          label: "OK",
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.white,
                          onPressed: () {
                            controller.reverse();
                            Future.delayed(Duration(milliseconds: 1000), () {
                              Navigator.pop(context, true);
                            });
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
