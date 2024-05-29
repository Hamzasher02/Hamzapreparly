import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF014880),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'Terms & Conditions',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'By downloading or using the app, these terms will\nautomatically apply to you – you should make sure\ntherefore that you read them carefully before using the\napp. You\'re not allowed to copy, or modify the app, any\npart of the app, or our trademarks in any way. You\'re\nnot allowed to attempt to extract the source code of\nthe app, and you also shouldn\'t try to translate the app\ninto other languages, or make derivative versions. The\napp itself, and all the trade marks, copyright, database\nrights and other intellectual property rights related to\nit, still belong to STEAM MIND. STEAM MIND is\ncommitted to ensuring that the app is as useful and\nefficient as possible. For that reason, we reserve the\nright to make changes to the app or to charge for its\nservices, at any time and for any reason. We will never\ncharge you for the app or its services without making it\nvery clear to you exactly what you\'re paying for. The\nPreparely app stores and processes personal data that\nyou have provided to us, in order to provide our\nService. It\'s your responsibility to keep your phone and\naccess to the app secure. We therefore recommend\nthat you do not jailbreak or root your phone, which is\nthe process of removing software restrictions and\nlimitations imposed by the official operating system of\nyour device. It could make your phone vulnerable to\nmalware/viruses/malicious programs, compromise\nyour phone\'s security features and it could mean that\nthe Preparely app won\'t work properly or at all. The\napp does use third party services that declare their\nown Terms and Conditions. Link to Terms and\nConditions of third party service providers used by the\napp',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                  child: Container(
                    height: 108.h,
                    width: 351.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFF7CB7FF)),
                    child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Google Play Services',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              'AdMob',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              'Google Analytics for Firebase',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              'Firebase Crashlytics',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'You should be aware that there are certain things that\nSTEAM MIND will not take responsibility for. Certain\nfunctions of the app will require the app to have an\nactive internet connection. The connection can be Wi-\nFi, or provided by your mobile network provider, but\nSTEAM MIND cannot take responsibility for the app not\nworking at full functionality if you don\'t have access to\nWi-Fi, and you don\'t have any of your data allowance\nleft. If you\'re using the app outside of an area with Wi-\nFi, you should remember that your terms of the\nagreement with your mobile network provider will still\napply. As a result, you may be charged by your mobile\nprovider for the cost of data for the duration of the\nconnection while accessing the app, or other third-party charges. In using the app, you\'re accepting\nresponsibility for any such charges, including roaming\ndata charges if you use the app outside of your home\nterritory (i.e., region or country) without turning off\ndata roaming. If you are not the bill payer for the\ndevice on which you\'re using the app, please be aware\nthat we assume that you have received permission\nfrom the bill payer for using the app. Along the same\nlines, STEAM MIND cannot always take responsibility\nfor the way you use the app i.e. You need to make sure\nthat your device stays charged – if it runs out of battery\nand you can\'t turn it on to avail the Service, STEAM\nMIND cannot accept responsibility. With respect to\nSTEAM MIND\'s responsibility for your use of the app,\nwhen you\'re using the app, it\'s important to bear in\nmind that although we endeavour to ensure that it is\nupdated and correct at all times, we do rely on third\nparties to provide information to us so that we can\nmake it available to you. STEAM MIND accepts no\nliability for any loss, direct or indirect, you experience as\na result of relying wholly on this functionality of the\nApp. At some point, we may wish to update the app.\nThe app is currently available on Android & iOS – the\nrequirements for both systems (and for any additional\nsystems we decide to extend the availability of the app\nto) may change, and you\'ll need to download the\nupdates if you want to keep using the app. STEAM\nMIND does not promise that it will always update the\napp so that it is relevant to you and/or works with the\nAndroid & iOS version that you have installed on your\ndevice. However, you promise to always accept\nupdates to the application when offered to you, we\nmay also wish to stop providing the app, and may\nterminate use of it at any time without giving notice of\ntermination to you. Unless we tell you otherwise, upon\nany termination,',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                  child: Container(
                    height: 108.h,
                    width: 351.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFF7CB7FF)),
                    child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '(a) the rights and licenses granted to you in these',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              'terms will end;',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              '(b) you must stop using the app, and (if needed) delete',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                            Text(
                              'it from your device.',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.5.sp,
                                      color: Color(0xffFFFFFF))),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'Changes to This Terms and Conditions',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'We may update our Terms and Conditions from time\nto time. Thus, you are advised to review this page\nperiodically for any changes. We will notify you of any\nchanges by posting the new Terms and Conditions on\nthis page. These terms and conditions are effective as\nof 2050-09-23',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'If you have any questions or suggestions about our\nTerms and Conditions do not hesitate to contact us at',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5.sp,
                            color: Color(0xffFFFFFF))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    'steamminds.apps@gmail.com.',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5.sp,
                            color: Color(0xff13ADFA))),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ));
  }
}
