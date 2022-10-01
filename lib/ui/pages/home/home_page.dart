import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/home/components/google_map_view.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: HomePageBody(ref),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody(this._ref, {super.key});

  final WidgetRef _ref;

  @override
  Widget build(BuildContext context) {
    final userState = _ref.watch(userStateProvider);

    return SizedBox(
      width: 375,
      height: 812,
      child: Material(
        color: Color(0xff28333f),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 34, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                width: 360,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.only(left: 6, right: 5, ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      width: 349,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(47),
                      ),
                      child: GoogleMapView(_ref),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.67),
              Container(
                width: 375,
                height: 295,
                padding: const EdgeInsets.only(left: 11, right: 12, ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      width: 352,
                      height: 247,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 23, ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Container(
                            width: 126,
                            height: 121,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Opacity(
                                  opacity: 0.50,
                                  child: Text(
                                    '${userState!.nickname}番札所',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      letterSpacing: 0.12,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  width: 126,
                                  height: 42,
                                  child: Text(
                                    '${userState.nickname}寺',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff43c465),
                                      fontSize: 35,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 27),
                          Container(
                            height: 201,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(
                                  width: 72,
                                  height: 72,
                                  child: Stack(
                                    children:[
                                      Container(
                                        width: 67,
                                        height: 67,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        width: 69,
                                        height: 69,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Color(0xfff14985), width: 5, ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 15,
                                        child: SizedBox(
                                          width: 56,
                                          height: 14,
                                          child: Text(
                                              (5000 - (userState.health?.totalSteps ?? 0)).toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 35,
                                        child: SizedBox(
                                          width: 56,
                                          height: 14,
                                          child: Text(
                                            "5000",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xff43c465),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 25,
                                        top: 33,
                                        child: Container(
                                          width: 25.50,
                                          height: 0.50,

                                        ),
                                      ),
                                      Positioned(
                                        left: 9,
                                        top: 24,
                                        child: SizedBox(
                                          width: 11,
                                          height: 15,
                                          child: Material(
                                            color: Color(0xffcdcdcd),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25),
                                SizedBox(
                                  width: 151,
                                  height: 105,
                                  child: Material(
                                    color: Color(0x19ffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 19, ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:[
                                          Container(
                                            width: 151,
                                            height: 67.50,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children:[
                                                SizedBox(
                                                  width: 151,
                                                  height: 48.91,
                                                  child: Text(
                                                    userState.health?.yesterday.steps.toString() ?? '0',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 48,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 3.91),
                                                SizedBox(
                                                  width: 87.24,
                                                  height: 14.67,
                                                  child: Text(
                                                    "Yesterday Steps",
                                                    style: TextStyle(
                                                      color: Color(0xffcdcdcd),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.67),
              SizedBox(
                width: 305,
                height: 64,
                child: Material(
                  color: Color(0xff2f3c50),
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 41, right: 40, ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Container(
                          width: 224,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                width: 32,
                                height: 32,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FlutterLogo(size: 32),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 32),
                              Container(
                                width: 32,
                                height: 32,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FlutterLogo(size: 32),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 32),
                              Container(
                                width: 32,
                                height: 32,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FlutterLogo(size: 32),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
