import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
                  'Privacy Policy',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'STEAM MIND built the Preparely app as a Free app.\nThis SERVICE is provided by STEAM MIND at no cost\nand is intended for use as is. This page is used to\ninform visitors regarding our policies with the\ncollection, use, and disclosure of Personal Information\nif anyone decided to use our Service. If you choose to\nuse our Service, then you agree to the collection and\nuse of information in relation to this policy. The\nPersonal Information that we collect is used for\nproviding and improving the Service. We will not use\nor share your information with anyone except as\ndescribed in this Privacy Policy. The terms used in this\nPrivacy Policy have the same meanings as in our\nTerms and Conditions, which is accessible at Preparely\nunless otherwise defined in this Privacy Policy.\nInformation Collection and Use\nFor a better experience, while using our Service,\nwe may require you to provide us with certain personally\nidentifiable information. The information that we\nrequest will be retained by us and used as described in\nthis privacy policy. The app does use third party\nservices that may collect information used to\nidentify you.Link to privacy policy of third party service\nproviders used by the app',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
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
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'AdMob',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'Google Analytics for Firebase',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'Firebase Crashlytics',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Log Data',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'We want to inform you that whenever you use our\nService, in a case of an error in the app we collect data\nand information (through third party products) on\nyour phone called Log Data. This Log Data may\ninclude information such as your device Internet\nProtocol ("IP") address, device name, operating system\nversion, the configuration of the app when utilizing\nour Service, the time and date of your use of the\nService, and other statistics.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Cookies',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Cookies are files with a small amount of data that are\ncommonly used as anonymous unique identifiers.\nThese are sent to your browser from the websites that\nyou visit and are stored on your device\'s internal\nmemory. This Service does not use these "cookies”\nexplicitly. However, the app may use third party code\nand libraries that use "cookies" to collect information\nand improve their services. You have the option to\neither accept or refuse these cookies and know when\na cookie is being sent to your device. If you choose to\nrefuse our cookies, you may not be able to use some\nportions of this Service.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Service Providers',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'We may employ third-party companies and\nindividuals due to the following reasons:',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
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
                            'To facilitate our Service;',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'To provide the Service on our behalf;',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'To perform Service-related services;',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                          Text(
                            'To assist us in analyzing how our Service is used.',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffFFFFFF))),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'We want to inform users of this Service that these\nthird parties have access to your Personal Information.\nThe reason is to perform the tasks assigned to them\non our behalf. However they are obligated not to\ndisclose or reason is to perform the tasks assigned to\nthem on our behalf. However, they are obligated not to\ndisclose or use the information for any other purpose.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Security',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'We value your trust in providing us your Personal\nInformation, thus we are striving to use commercially\nacceptable means of protecting it. But remember that\nno method of transmission over the internet, or\nmethod of electronic storage is 100% secure and\nreliable, and we cannot guarantee its absolute security.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Links to Other Sites',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'This Service may contain links to other sites. If you click\non a third-party link, you will be directed to that site.\nNote that these external sites are not operated by us.\nTherefore, we strongly advise you to review the Privacy\nPolicy of these websites. We have no control over and\nassume no responsibility for the content, privacy\npolicies, or practices of any third-party sites or services.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Children\'s Privacy',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'These Services do not address anyone under the age\nof 13. We do not knowingly collect personally\nidentifiable information from children under 13 years\nof age. In the case we discover that a child under 13\nhas provided us with personal information, we\nimmediately delete this from our servers. If you are a\nparent or guardian and you are aware that your child\nhas provided us with personal information, please\ncontact us so that we will be able to do necessary\nactions.',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'Changes to This Privacy Policy',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'We may update our Privacy Policy from time to time.\nThus, you are advised to review this page periodically\nfor any changes. We will notify you of any changes by\nposting the new Privacy Policy on this page. This policy\nis effective as of 2050-09-23',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
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
                          fontSize: 14.sp,
                          color: Color(0xffFFFFFF))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  'If you have any questions or suggestions about our\nPrivacy Policy, do not hesitate to contact us at',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
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
                          fontSize: 12.sp,
                          color: Color(0xff13ADFA))),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
