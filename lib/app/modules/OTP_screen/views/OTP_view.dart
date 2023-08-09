import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/genrate_otp_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/location_details.dart';


class OtpViewScreen extends StatefulWidget {
  final String? mobile;
  OtpViewScreen({Key? key,this.mobile}) : super(key: key);

  @override
  State<OtpViewScreen> createState() => _OtpViewScreenState();
}

class _OtpViewScreenState extends State<OtpViewScreen> {
  String? otp;
  bool toggle = true;
  bool hasError = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  TextEditingController otpCon1 = new TextEditingController();


  ontapOTP() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    otp = preferences.getString('otp');
    print('=============${otp}');

  }



  Widget getTitle() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      height: 80,
      width: 120,
      child: Image.asset(
        SPLASH_IMAGE,
        fit: BoxFit.fill,
      ),
    );
  }

  Container getBackButton() {
    return Container(
      padding: EdgeInsets.all(getWidth(20)),
      height: getHeight(50),
      width: getHeight(50),
      child: Image.asset(
        BACK_BUTTON,
        fit: BoxFit.fill,
      ),
    );
  }


  Row getHeader() {
    return  Row(
      children: <Widget>[
        GestureDetector(
          onTap:(){
            Get.back();
          },
          child: getBackButton(),
        ),
        const Spacer(
          //flex: 1,
        ),
        getTitle(),
        const Spacer(flex: 2)
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // generateOtp();
    ontapOTP();
    widget.mobile;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    beginWidth = Dimension.max(20.toPercentLength, 700.toPXLength);
    beginHeight = (90.toVHLength - 10.toPXLength);

    endWidth = Dimension.clamp(200.toPXLength, 40.toVWLength, 200.toPXLength);
    endHeight = 50.toVHLength +
        10.toPercentLength -
        Dimension.min(4.toPercentLength, 40.toPXLength);

    //LocalNotificationService.initialize(context);
    return
      SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: getBackButton(),
              ),
              centerTitle: true,
              title:  getTitle(),
            ),
            backgroundColor: Colors.white,
            body:
            Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:  350.toPercentLength.value,
                          child: Image.asset(
                            LOGIN_BACKGRAUND,
                            fit: BoxFit.fill,
                          ),
                        ),

                      ],)

                ),


                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(top: 200),
                        //height: 200.toPercentLength.value,
                        child:  Padding(
                            padding: EdgeInsets.all(20),
                            child: Image.asset(
                              CONGRACULATION,
                              fit: BoxFit.fill,
                            )
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(00),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: digit_OTP,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 14,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(00),
                              child: TextFieldShow(
                                color: Colors.red,
                                text: '',
                                //"on ${widget.mobile}",
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontsize: 14,
                              ),
                            ),
                            // Container(
                            //   height: 20,
                            //   width: 20,
                            //   padding: EdgeInsets.all(00),
                            //   margin: EdgeInsets.fromLTRB(10, 00, 00, 00),
                            //   child:  Image.asset(
                            //     EDIT_MOBILE,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                          ],),
                      ),

                      Text('OTP: ${otp}'),
                      SizedBox(height: 20,),
                      GestureDetector(
                          onLongPress: () {
                            print("LONG");
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content:
                                    Text("Paste clipboard stuff into the pinbox?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () async {
                                            var copiedText =
                                            await Clipboard.getData("text/plain");
                                            // if (copiedText.text.isNotEmpty) {
                                            //   // controller1.text = copiedText.text;
                                            // }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("YES")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No"))
                                    ],
                                  );
                                });
                          },
                          child:
                          Padding(
                              padding: EdgeInsets.only(left: 60,right: 60),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
                                controller: otpCon1,
                                obscureText: false,
                                obscuringCharacter: '*',
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 60,
                                  fieldWidth: 50,
                                  selectedFillColor: Colors.white,
                                  activeColor: Colors.black,
                                  selectedColor: Colors.black,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: Colors.black,
                                  activeFillColor: hasError ? Colors.white : Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                textStyle: TextStyle(fontSize: 20, height: 1.6,color: Colors.black),
                                backgroundColor: Colors.white,
                                enableActiveFill: true,

                                // errorAnimationController: errorController,
                                // controller: controller1,
                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                // onTap: () {
                                //   print("Pressed");
                                // },
                                onChanged: (value) {

                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              )
                          )

                      ),
                      boxHeight(30),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(otp==otpCon1.text){
                              // setState(() {
                              //   loading= true;
                              // });
                              verifyOtp();
                            }else{
                              setSnackbar("Wrong Otp", context);
                            }
                          },
                          child: Container(
                            width: getWidth(213),
                            height: getHeight(80),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0,1],
                                  colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049),]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: !loading?text("Verify",
                                  fontFamily: fontMedium,
                                  fontSize: 12.sp,
                                  textColor: Colors.white
                              ):loadingWidget(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: receive_OTP,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            loading= true;
                          });
                          otpGenerate();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: !loading?TextFieldShow(
                            color: Colors.red,
                            text: Resend_OTP,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            fontsize: 14,
                          ):loadingWidget(),
                        ),
                      ),
                    ],),
                )

              ],
            )
        ),
      );
  }
  bool loading = false;
  //String otp = "";
  // generateOtp() async{
  //   Map param =  {};
  //   //param['country_code']= "91";
  //   //param['mobile']= widget.mobile;
  //   param['device_token']= "test";
  //   print(param);
  //   var res = await http.post(Uri.parse(baseUrl+"generateOtp"),body: param,headers: {
  //     "Accept-Language" : langCode,
  //   });
  //   Map response = jsonDecode(res.body);
  //   print(response);
  //   setState(() {
  //     loading = false;
  //   });
  //   setSnackbar(response['otp'].toString(), context);
  //   if(response['status'].toString()=="1"){
  //     setState(() {
  //       otp = response['otp'].toString();
  //     });
  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP_view(param['mobile'])));
  //   }else{
  //
  //   }
  //
  // }


  otpGenerate() async {

    var headers = {
      'Cookie': 'ci_session=7c5849814e97c82af207dc11c9ff6cacca040282'
    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'generateOtp'));
    request.fields.addAll({
      'country_code': '91',
      'mobile': '${widget.mobile}',

    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = genrateOtpModel.fromJson(json.decode(Result));
      setState(() {
        loading = false;
      });

      if(finalResult.status==1){
            setState(() {
              otp = finalResult.otp.toString();
            });
          }
    }
    else {
      print(response.reasonPhrase);
    }

  }


  verifyOtp() async{
    Map param =  {};
    param['country_code']= "91";
    param['mobile']= widget.mobile;
    print('my mobile numberrrrr${widget.mobile}');
    param['otp']= otp;
    print('Newwwwwwwwww otp${otp}');
    print(param);
    var res = await http.post(Uri.parse(baseUrl+"verifyOtp"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print('___Response_______${response}____${param}_____');
    print(response);
    setState(() {
      loading = false;
    });

    if(response['status'] == 1){
      setSnackbar(response['message'].toString(), context);
      App.localStorage
          .setString("userId", response['data']['user_id'].toString());
      curUserId = response['data']['user_id'].toString();
      GetLocation location = new GetLocation((result){
        address = result.first.addressLine;
        latitude = result.first.coordinates.latitude;
        longitude = result.first.coordinates.longitude;
      });
       location.getLoc();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP_view(param['mobile'])));
    }else{

    }

  }
}

