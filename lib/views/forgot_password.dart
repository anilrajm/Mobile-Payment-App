import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  int currentStep = 0;

  late String mobileNumber;
  late String otp;
  late String password;
  late String confirmPassword;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Step> getSteps() => [
          buildMobileNumStep(),
          buildOtpStep(),
          buildNewPasswordStep(),
        ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset("asset/icons/forgot_pass_image.png",
                    fit: BoxFit.fitWidth, height: 297.815.h),
              ),
              // BrandLogo()
            ],
          ),
          Container(
            child: Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: currentStep,
              steps: getSteps(),
              type: StepperType.vertical,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  print("Completed");
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                final isLastStep = currentStep == getSteps().length - 1;

                return Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: controls.onStepContinue,
                          child: Text(isLastStep ? "Confirm" : "Next"),
                        ),
                      ),
                      SizedBox(
                        width: 39.87.w,
                      ),
                      if (currentStep != 0)
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: controls.onStepCancel,
                            child: const Text("Cancel"),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
    ),
        ),
      ),
    );
  }

  Step buildNewPasswordStep() {
    return Step(
      state: currentStep == 2 ? StepState.editing : StepState.indexed,
      title: const Text('Enter new password'),
      content: Column(
        children: [
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(labelText: 'New password'),
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirm password'),
            onChanged: (value) {
              setState(() {
                confirmPassword = value;
              });
            },
          ),
        ],
      ),
      isActive: currentStep >= 2,
    );
  }

  Step buildOtpStep() {
    return Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text('Enter OTP'),
      content: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'OTP'),
            onChanged: (value) {
              setState(() {
                otp = value;
              });
            },
          ),
        ],
      ),
      isActive: currentStep >= 1,
    );
  }

  Step buildMobileNumStep() {
    return Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      title: const Text('Enter mobile number'),
      content: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Mobile number'),
            onChanged: (value) {
              setState(() {
                mobileNumber = value;
              });
            },
          ),
        ],
      ),
      isActive: currentStep >= 0,
    );
  }
}
