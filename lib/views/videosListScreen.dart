import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';

import '../Widgets/youtubeVideoPlayer.dart';
import '../controllers/videosController.dart';
import '../models/videosModel.dart';

class VideosListScreen extends StatefulWidget {
  final String chapterClicked;    //  -----> compared with "videoList.chapterid.id"

   VideosListScreen({Key? key,
    required this.chapterClicked   //this is the id of clicked chapter that has passed here
  }) : super(key: key);

  @override
  State<VideosListScreen> createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  final VideoController videoController = Get.put(VideoController());

  // we take the dataType of 'myVideosList' as 'VideoList' because we are assigning all items to "myVideosList" and all those items belong to a list of type 'VideoList' in the Model Class
  late RxList<VideoList> myVideosList;

  @override
  void initState() {
    super.initState();

    // we are initializing 'myVideosList' with list of type 'VideoList' because we are assigning all items to "myVideosList" and all those items belong to a list of type 'VideoList'
    myVideosList = RxList<VideoList>([]);

    ever(videoController.videoModelObj, (_) {
      if(videoController.videoModelObj.value != null && videoController.videoModelObj.value!.videoList != null) {
        myVideosList.assignAll(videoController.videoModelObj.value!.videoList!.where((videoCompareObj) => videoCompareObj.chapterid!.id == widget.chapterClicked));
        printFilteredVideoList();
      }
    });
  }

  void printFilteredVideoList() {
    print("printing list of my filtered videos[myVideosList] in videoListScreen:");
    for (var video in myVideosList) {
      print("Subject ID: ${video.id}, Name: ${video.name}, videoForeignKey: ${video.chapterid!.id}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Video List"),
        ),

        body: Obx(() {
          if (videoController.isLoading.value) {

            return videoShimmerItem();

          } else if(myVideosList.isEmpty) {
            return Center(
              child: Text("Videos will be added soon",style: TextStyle(fontSize: 16,color: Colors.black),),
            );
          } else {

            return GridView.builder(
              padding: EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
              itemCount: myVideosList.length,
               itemBuilder: (BuildContext context, int index) {
                          final videosObj = myVideosList[index];

                          return GestureDetector(
                            onTap: () async {

                              String videoUrl = videosObj.videoUrl!;   // the "url" of video clicked will now be passed to video player

                              Get.to( ()=> YoutubeVideoPlayer(videoClickedUrl: videoUrl,), transition: Transition.downToUp,duration: const Duration(milliseconds: 220));

                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16, left: 16, right:  16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    //The scrollAxis property is set to Axis.horizontal to make the text scroll horizontally. The crossAxisAlignment property is set to CrossAxisAlignment.start to align the text to the left.
                                    //
                                    // The blankSpace property adds space between the end and start of the text to make it look smoother. The velocity property controls the speed of the scrolling text.
                                    //
                                    // By using the Marquee widget, the text will keep moving automatically, and the user can read the hidden text.

                                    SizedBox(
                                      height: 25, // set a fixed height for the SizedBox widget
                                      child: Marquee(
                                        text: videosObj.name!,
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                          color: Color(0xff004880),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        blankSpace: 20.0,
                                        velocity: 24.0,
                                        numberOfRounds: 2, // set to null to stop the text from repeating
                                      ),
                                    ),



                                    SizedBox(height: 8),

                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width, // set a fixed width for the SizedBox widget
                                       height: 150,
                                        child: Text(
                                          videosObj.description!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            color: const Color(0xff004880),
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),


                                //    SizedBox(height: 8),
                                  Spacer(),

                                    Align(
                                      alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 7),
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Icon(
                                                Icons.play_circle,
                                              size: MediaQuery.of(context).size.width * 0.08,
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
            );

            // return ListView.builder(
            //   itemCount: myVideosList.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final videosObj = myVideosList[index];
            //
            //     return GestureDetector(
            //       onTap: () async {
            //
            //         String videoUrl = videosObj.videoUrl!;   // the "url" of video clicked will now be passed to video player
            //
            //         Get.to( ()=> YoutubeVideoPlayer(videoClickedUrl: videoUrl,));
            //
            //       },
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //         ),
            //         elevation: 5,
            //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         child: Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 videosObj.name!,
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //               SizedBox(height: 8),
            //               Text(
            //                 videosObj.description!,
            //                 style: TextStyle(
            //                   fontSize: 16,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );

          }
        }),
      ),
    );
  }
}

class videoShimmerItem extends StatelessWidget {
  const videoShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right:  16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),


                  //    SizedBox(height: 8),
                  Spacer(),

                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Icon(
                            Icons.play_circle,
                            size: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
