import 'package:cruise/src/common/feedback_rest_action.dart';
import 'package:cruise/src/common/style/global_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:wheel/wheel.dart';

import 'feedback_controller.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var submitting = false;
    String? feedbackContent;
    double screenWidth = MediaQuery.of(context).size.width;

    void handleSubmitFeedback(String feedback) async {
      submitting = true;
      HttpResult result = await FeedbackRestAction.submitFeedback(feedback);
      if (result.result == Result.error) {
        Fluttertoast.showToast(
            msg: "意见提交失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "提交成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      submitting = false;
    }

    return GetBuilder<FeedbackController>(
        init: FeedbackController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("意见建议"),
            ),
            body: SafeArea(
                child: Form(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16, top: 16),
                    child: TextFormField(
                      maxLines: null,
                      autocorrect: false,
                      onChanged: (value) {
                        feedbackContent = value;
                      },
                      obscureText: false,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        labelText: '反馈内容',
                        contentPadding: EdgeInsets.all(10.0), //控制输入控件高度
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "反馈内容不能为空";
                        }
                        return null;
                      },
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: Builder(
                          builder: (context) {
                            return ButtonTheme(
                                minWidth: screenWidth * 0.85,
                                height: 50.0,
                                child: Center(
                                    child: ElevatedButton(
                                  style: GlobalStyle.getButtonStyle(context),
                                  onPressed: () async {
                                    handleSubmitFeedback(feedbackContent!);
                                  },
                                  child: submitting
                                      ? SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          ),
                                        )
                                      : Text("提交"),
                                )));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
