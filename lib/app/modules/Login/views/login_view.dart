import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/new_screen/forget_screen.dart';
import 'package:indianmilan/app/utils/ColorClass.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/location_details.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/genrate_otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../OTP_screen/views/OTP_view.dart';
import '../../Register/views/Register_view.dart';

class login_view extends StatefulWidget {


  login_view({Key? key,}) : super(key: key);

  @override
  _login_viewState createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {


  bool toggle = true;
  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  TextEditingController emailCon = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController contyCodeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();







  // Function to handle Facebook login
  // void facebookLogin() async {
  //   try {
  //     // Log in with Facebook
  //     final LoginResult result = await FacebookAuth.instance.login();
  //
  //     // Check if the login was successful
  //     if (result.status == LoginStatus.success) {
  //       // Retrieve user information
  //       final AccessToken accessToken = result.accessToken!;
  //       final userData = await FacebookAuth.instance.getUserData();
  //
  //       // Use the user information as needed
  //       String userId = accessToken.userId;
  //       String userName = userData['name'];
  //       String userEmail = userData['email'];
  //
  //       // Display the user information
  //       print('ID: $userId');
  //       print('Name: $userName');
  //       print('Email: $userEmail');
  //
  //       // You can also send the access token to your server for verification
  //     } else {
  //       // Handle login error
  //       print('Facebook login failed');
  //     }
  //   } catch (error) {
  //     // Handle error
  //     print('Facebook login error: $error');
  //   }
  // }

  void googleSignIn() async {
    // Create a new instance of GoogleSignIn
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Start the Google Sign-In process
      GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        // Retrieve user information
        String userId = account.id;
        String? userName = account.displayName;
        String userEmail = account.email;
        // String userPhotoUrl = account.photoUrl;

        // Use the user information as needed
        print('ID: $userId');
        print('Name: $userName');
        print('Email: $userEmail');
        // print('Photo URL: $userPhotoUrl');

        // You can also send the ID token to your server for verification
      }
    } catch (error) {
      // Handle error if sign-in fails
      print('Sign-in error: $error');
    }
  }


  Widget getTitle() {
    return Container(
      margin: EdgeInsets.only(left: 00),
      child: TextFieldShow(
        color: Colors.orangeAccent,
        text: LOGIN,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w300,
        fontsize: 25,
      ),
    );
  }

  Container getBackButton() {
    return
      Container(
        margin: EdgeInsets.only(left: getWidth(40)),
        height: getHeight(50),
        width: getHeight(50),
        child: Image.asset(
          BACK_BUTTON,
          fit: BoxFit.fill,
        ),
      );;
  }

  Row getHeader() {
    return  Row(
      children: <Widget>[

        const Spacer(
          flex: 1,
        ),
        getTitle(),

        const Spacer(flex: 2)
      ],
    );
  }
  bool show = true;
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
    return  SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                width: getWidth(720),
                height: getHeight(552),
                child: Image.asset(
                  LOGIN_BACKGRAUND,
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key:_formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      boxHeight(40),
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: getBackButton(),
                      ),
                      boxHeight(57),
                      Center(
                        child: text("Login",
                            fontFamily: fontMedium,
                            fontSize: 24.sp,
                            textColor: Color(0xffFECC2F)
                        ),
                      ),
                      boxHeight(97),
                      Center(
                        child: Container(
                          width: getWidth(625),
                          padding: EdgeInsets.symmetric(horizontal: getWidth(24),vertical: getHeight(40)),
                          decoration: boxDecoration(
                            radius: 20,
                            showShadow: true,
                            bgColor: Colors.white,
                          ),
                          child:Column(
                            children: <Widget>[
                              // Container(
                              //   width: 80,
                              //   child:TextFormField(
                              //     controller: contyCodeController,
                              //     decoration: InputDecoration(
                              //         hintText: '+91',
                              //         border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(11),
                              //         )
                              //     ),
                              //   )
                              //   // TextFieldDesigned(
                              //   //   controller:contyCodeController,
                              //   //   fontSize: 14,
                              //   //   // maxLength: 30,
                              //   //   // minLines: 1,
                              //   //   hintText: "contry code",
                              //   //  // autovalidateMode: AutovalidateMode.onUserInteraction,
                              //   //   readOnly: false,
                              //   //   keyboardType: TextInputType.phone,
                              //   //   // prefixIcon: Icon(
                              //   //   //   Icons.email_outlined,
                              //   //   //   color: Colors.black,
                              //   //   //   size: 16.0,
                              //   //   // ),
                              //   // ),
                              // ),
                              // SizedBox(width:20,),
                              Container(
                                child: TextFieldDesigned(
                                  controller:mobileController,
                                  maxLength:10,
                                  validator: (val) {
                                    if (!(val!.length > 5) && val.isNotEmpty) {
                                      return "Enter valid number of 10 characters!";
                                    }
                                    return null;
                                  },
                                  hintText: "Enter Mobile Number",
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  readOnly: false,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                    size: 16.0,
                                  ),
                                ),
                                // TextFieldDesigned(
                                //   controller:mobileController,
                                //   maxLength:10,
                                //   hintText: "Enter Mobile Number",
                                //  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                //   readOnly: false,
                                //   keyboardType: TextInputType.phone,
                                //   prefixIcon: Icon(
                                //     Icons.phone,
                                //     color: Colors.black,
                                //     size: 16.0,
                                //   ),
                                // ),
                              ),



                              // boxHeight(60),
                              // TextFormField(
                              //   maxLength: 20,
                              //   style: TextStyle(color: Colors.black),
                              //   controller: passCon,
                              //   obscureText: show,
                              //   decoration: InputDecoration(
                              //     focusedErrorBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color(0xffC4C4C4)),
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color(0xffC4C4C4)),
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color(0xffC4C4C4)),
                              //       //36325A
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     errorBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color(0xffC4C4C4)),
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     counterText: '',
                              //     border: InputBorder.none,
                              //     prefixIcon: Icon(
                              //       Icons.lock_outline,
                              //       color: Colors.black,
                              //       size: 16.0,
                              //     ),
                              //     filled: true,
                              //     fillColor: Color(0xffffffff),
                              //     hintText: 'Password'.tr,
                              //     hintStyle: TextStyle(fontSize: 14.0, color:Color(0xff000000)),
                              //     suffixIcon: GestureDetector(
                              //       behavior: HitTestBehavior.translucent,
                              //       onTap: () {
                              //         setState(() {
                              //           show = !show;
                              //         });
                              //       },
                              //       child: Icon(
                              //         show
                              //             ? Icons.visibility_off_outlined
                              //             : Icons.visibility_outlined,
                              //         size: 24,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //
                              //   ),
                              // ),
                              boxHeight(32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  /* GestureDetector(
                                      onTap: (){
                                        Get.toNamed(Routes.OTP_SCREEN);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: TextFieldShow(
                                          color: Colors.red,
                                          text: LOGIN_WITH_OTP,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          fontsize: 14,
                                        ),
                                      ),
                                    ),*/
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetScreen()));
                                    },
                                    child: text("Forgot Password",
                                        fontFamily: fontMedium,
                                        fontSize: 10.sp,
                                        textColor: Color(0xffFF7B7B)
                                    ),
                                  ),
                                ],),
                            ],),
                        ),
                      ),
                      boxHeight(90),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(_formKey.currentState!.validate());
                            if(mobileController.text.isEmpty || mobileController.text== null){
                            setSnackbar('Please enter valid mobile number', context);
                              return;
                            }
                            /* if(emailCon.text==""){
                                setSnackbar("Please Enter Email ID", context);
                                return;
                              }*/
                            // if(passCon.text==""){
                            //   setSnackbar("Please Enter Valid Password", context);
                            //   return;
                            // // }
                            setState(() {
                              loading = true;
                            });
                            //login();
                            otpGenerate();
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(95),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0,1],
                                  colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049),]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child:text("Login",
                                    fontFamily: fontMedium,
                                    fontSize: 14.sp,
                                    textColor: Colors.white
                                )
                              // :loadingWidget(color: Colors.white,),
                            ),
                          ),
                        ),
                      ),

                      boxHeight(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {

                              //facebookLogin();
                            },
                            child: CircleAvatar(
                                maxRadius: 20,
                                child: Image.asset('assets/Facebook_Logo.png')),
                          ),
                          SizedBox(width: 50,),
                          InkWell(
                            onTap: () {
                              googleSignIn();

                            },
                            child: CircleAvatar(
                                maxRadius: 20,
                                backgroundColor: ColorClass.whitColor,
                                child: Image.asset('assets/google_image2.png')),
                          ),
                        ],
                      ),
                      boxHeight(100),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_view()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text("Don’t have an account?",
                                fontFamily: fontMedium,
                                fontSize: 10.sp,
                                textColor: Colors.black
                            ),
                            text(" Register Now",
                                fontFamily: fontMedium,
                                fontSize: 10.sp,
                                textColor: Colors.red
                            ),
                          ],
                        ),
                      ),

                    ],),
                ),
              )




            ],
          )
      ),
    );
  }
  bool loading = false;
  String otp = "";
  otpGenerate() async {
    var headers = {
      'Cookie': 'ci_session=7c5849814e97c82af207dc11c9ff6cacca040282'
    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'generateOtp'));
    request.fields.addAll({
      'country_code': '91',
      'mobile': '${mobileController.text}',

    });

    print('qqqqqqqqqqqqqqqqqqqq${request.fields}');
    print('qqqqqqqqqqqqqqqqqqqqq${request.url}');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('${response.statusCode}');

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = genrateOtpModel.fromJson(json.decode(Result));
      int? otp = finalResult.otp;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('otp',otp.toString());
      print('otpppppppppp${otp}');
      setState(() {
        loading = false;
      });
      if(finalResult.status==1){
        Fluttertoast.showToast(msg: '${finalResult.message}');
        Navigator.push(context,MaterialPageRoute(builder:(context)=>OtpViewScreen(
          mobile:mobileController.text.toString(),
        )));

      }else{
        Fluttertoast.showToast(msg: 'Something Went Wrong');
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }


  login() async{
    Map param =  {};

    await App.init();
    param['email']= emailCon.text;
    // param['password']= passCon.text;
    param['lan']= langCode;
    param['device_type']= "Android";
    param['device_token']= fcmToken;
    print("paramters here" + param.toString());
    print("api here  ${baseUrl}login");
    var res = await http.post(Uri.parse(baseUrl+"login"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    print('Login---------------${param}');
    print(res.body.toString());
    print(res.headers.toString());
    Map response = jsonDecode(res.body);
    print(response.toString());
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if(response['status'].toString()=="1"){
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
    }else{

    }

  }
}

