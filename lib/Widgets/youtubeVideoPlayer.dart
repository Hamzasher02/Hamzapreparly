

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../responsive.dart';
import '../size_config.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String videoClickedUrl;

  const YoutubeVideoPlayer({
    Key? key,
    required this.videoClickedUrl,
  }) : super(key: key);

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer>
    with WidgetsBindingObserver {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register observer

    final videoID = YoutubePlayer.convertUrlToId(widget.videoClickedUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoID ?? '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this); // Unregister observer
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final newIsFullScreen =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (newIsFullScreen != _isFullScreen) {
      setState(() {
        _isFullScreen = newIsFullScreen;
        // Perform your desired actions here
        print("Fullscreen status: $_isFullScreen");
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);    // this 'piece of code' initializes all the 'late' variables in the 'videoInit' in the 'size_config' file so that we can use 'defaultSize'

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              Padding(
                //This padding is given so that the video player can adjust to the sides of the mobile screen in landscape mode
                padding: EdgeInsets.symmetric(vertical: Responsive.isSmallMobile(context) ? 5 : 24),
                child: YoutubePlayerBuilder(
                  // Your player setup here
                  player: YoutubePlayer(
                    controller: _controller,
                    // ...
                  ),
                  builder: (context, player) {
                    return Center(child: player);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class YoutubeVideoPlayer extends StatefulWidget {
//
//   final String videoClickedUrl;
//
//   const YoutubeVideoPlayer({Key? key,
//     required this.videoClickedUrl
//   }) : super(key: key);
//
//   @override
//   State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
// }
//
// class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
//
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // I have forcefully Enable landscape mode on this video player only while rest of the app is in Forced Portrait mode
//     // and when i exit the video player i have disposed of the landscape orientation so as not to cause problem in rest of the screens
//     // because "systemChrome" command even if applied on an individual screen effects all the screens.
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//
//     final videoID = YoutubePlayer.convertUrlToId(widget.videoClickedUrl);   // assigning the dynamic Youtube video URL to videoID variable
//
//     _controller = YoutubePlayerController(
//         initialVideoId: videoID! ?? '',
//         flags: const YoutubePlayerFlags(
//           mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//         )
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();          // on exit from screen dispose the controller
//
//     // Disable landscape mode when i exit the video player by disposing of the landscape orientation so as not to cause problem in rest of the screens
//     // because "systemChrome" command even if applied on an individual screen effects all the screens.
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//      SizeConfig().init(context);     // this 'piece of code' initializes all the 'late' variables in the 'videoInit' in the 'size_config' file so that we can use 'defaultSize'
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//
//             return LayoutBuilder(
//                 builder: (context, constraints) {
//
//                   final videoWidth = constraints.maxWidth;
//                   final videoHeight = constraints.maxHeight;
//
//                   // Calculate the aspect ratio based on device orientation
//                   final aspectRatio = orientation == Orientation.portrait
//                       ? 16 / 9
//                       : 9/16;   // videoWidth/videoHeight
//                   return SizedBox(
//                     width: videoWidth,
//                     height: videoHeight,
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         final currentOrientation = MediaQuery.of(context).orientation;   // This 'currentOrientation' variable is declared to get the orientation of the device
//                         final isLandscape = currentOrientation == Orientation.landscape;  // Here if the orientation is landscape we store it on the 'currentOrientation'.
//
//                         return Padding(     /// ...  without this symmetric padding the video player crops the video in landscape mode
//                           padding: isLandscape
//                               ? EdgeInsets.symmetric(vertical:  SizeConfig.defaultSize * 1.4)
//                           // EdgeInsets.symmetric(
//                           //     vertical: SizeConfig.defaultSize * 2.5,  // 'SizeConfig.defaultSize' is equal to 10 for iphone 11 pro and multiply by 2.5 equals to 25
//                           //     horizontal:SizeConfig.defaultSize * 6.0 // 'SizeConfig.defaultSize' is equal to 10 for iphone 11 pro and multiply by 6 equals to 60
//                           // )
//                               : EdgeInsets.zero,                       // if portrait then no padding is required
//
//                           child: AspectRatio(
//                             aspectRatio: aspectRatio,
//                             child: YoutubePlayerBuilder(
//                               player: YoutubePlayer(
//                                 controller: _controller,
//                                 showVideoProgressIndicator: true,
//                                 progressIndicatorColor: Colors.red,
//                                 actionsPadding: const EdgeInsets.only(left: 16.0),
//                                 progressColors: const ProgressBarColors(
//                                     // playedColor: Colors.red,
//                                     // handleColor: Colors.redAccent
//                                             playedColor: Color(0xfffe0002),
//                                             handleColor: Colors.white,
//                                             backgroundColor: Colors.black38
//                                 ),
//
//                                   topActions: [  // this will show items on top of video
//                                     const SizedBox(width: 8.0,),
//                                     Expanded(
//                                         child: Text(
//                                           _controller.metadata.title,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18.0
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 1,
//                                         )
//                                     )
//                                   ],
//                               ),
//
//                               builder: (context, player) {
//                                 return Scaffold(
//                                   body: Container(
//                                     height: MediaQuery.of(context).size.height,
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                       color: Colors.black
//                                     ),
//                                     child: Center(
//                                       child: player,
//                                     ),
//                                   ),
//                                 );
//
//                                 // return FittedBox(
//                                 //   fit: BoxFit.contain,
//                                 //   child: Align(
//                                 //     alignment: Alignment.center,
//                                 //     child: player,
//                                 //   ),
//                                 //
//                                 // );
//
//
//                               },
//
//                             ),
//                           ),
//                         );
//                       },
//                     )
//
//
//
//                   );
//                 },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




//  ................................................ Better code .....................   ........................   //
//  ................................................ Better code .....................   ........................   //

//
// class YoutubeVideoPlayer extends StatefulWidget {
//   final String videoClickedUrl;
//   const YoutubeVideoPlayer({super.key, required this.videoClickedUrl});
//
//   @override
//   State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
// }
//
// class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
//
//   late Size size;
//
//   late YoutubePlayerController _controller;
//   late TextEditingController _idController;
//   late TextEditingController _seekToController;
//
//   late PlayerState _playerState;
//
//   double _volume = 100;
//   bool _muted = false;
//   bool _isPlayerReady = false;
//
//   final List<String> _ids = [
//     '11OWuPcElJw',
//     'YA7XJujzfJ0',
//     '11OWuPcElJw',
//     'uHIZ5SLaGRA'
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = YoutubePlayerController(
//         initialVideoId: _ids.first,    // the id of first video is passed to the player and the rest of them will follow
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: true,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//       )
//     )..addListener(listener);
//
//     _idController = TextEditingController();
//     _seekToController = TextEditingController();
//
//     _playerState = PlayerState.unknown;
//   }
//
//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//       });
//     }
//   }
//
//   //Now we handle on 'deActivate' and 'dispose'
//   @override
//   void deactivate() {
//     super.deactivate();
//
//     _controller.pause();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     _controller.dispose();
//     _idController.dispose();
//     _seekToController.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return YoutubePlayerBuilder(
//
//       onEnterFullScreen: () { // here we adjust the player according to when it enters full screen after clicking 'FullScreenButton'
//         print('full screen entered');
//
//         SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeRight,
//             DeviceOrientation.landscapeLeft
//           ]);
//
//       },
//
//       onExitFullScreen: () {
//        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//
//       player: YoutubePlayer(
//         showVideoProgressIndicator: true,
//         progressColors: const ProgressBarColors(
//           playedColor: Color(0xfffe0002),
//           handleColor: Colors.white,
//           backgroundColor: Colors.black38
//         ),
//         controller: _controller,  // initializing this controller in the "initState" above
//
//         topActions: [  // this will show items on top of video
//           const SizedBox(width: 8.0,),
//           Expanded(
//               child: Text(
//                 _controller.metadata.title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18.0
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               )
//           )
//         ],
//
//         onReady: () {
//           _isPlayerReady = true;
//         },
//         onEnded: (data) {
//           _controller.load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
//         },
//       ),
//
//       // now we will set the player on the screen
//       builder: (context, player) => Scaffold(
//         body: Container(
//           height: size.height,
//           width: size.width,
//           decoration: BoxDecoration(
//               color: Colors.white
//           ),
//           child: Center(
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 player,
//
//                 // Now we add 'next', 'previous', 'play', 'pause' buttons
//
//                 // Padding(
//                 //     padding: EdgeInsets.all(8.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //     children: [
//                 //       Row(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //         children: [
//                 //
//                 //           // Expanded(
//                 //           //   child: Padding(
//                 //           //     padding: EdgeInsets.symmetric(horizontal: 3),
//                 //           //     child: ElevatedButton(
//                 //           //       onPressed: _isPlayerReady ? ()=> _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId)-1) % _ids.length]) : null,
//                 //           //
//                 //           //       child: Text("Previous", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
//                 //           //
//                 //           //       style: ButtonStyle(
//                 //           //
//                 //           //         shape: MaterialStateProperty.all(const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),),
//                 //           //         backgroundColor: MaterialStateProperty.all(Colors.white),
//                 //           //         foregroundColor: MaterialStateProperty.all(Colors.black),
//                 //           //
//                 //           //         overlayColor: MaterialStateProperty.resolveWith<Color?>(      //
//                 //           //               (Set<MaterialState> states) {
//                 //           //             if (states.contains(MaterialState.pressed))
//                 //           //               return Color(0xff004880); //<-- SEE HERE
//                 //           //             return null; // Defer to the widget's default.
//                 //           //           },
//                 //           //         ),
//                 //           //       ),
//                 //           //
//                 //           //     ),
//                 //           //   ),
//                 //           // ),
//                 //
//                 //
//                 //           // Expanded(
//                 //           //   child: Padding(
//                 //           //     padding: EdgeInsets.symmetric(horizontal: 3),
//                 //           //     child: ElevatedButton(
//                 //           //       onPressed: _isPlayerReady ? ()=> _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId)+1) % _ids.length]) : null,
//                 //           //
//                 //           //       child: Text("Next", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),),
//                 //           //
//                 //           //       style: ButtonStyle(
//                 //           //
//                 //           //         shape: MaterialStateProperty.all(const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),),
//                 //           //         backgroundColor: MaterialStateProperty.all(Colors.white),
//                 //           //         foregroundColor: MaterialStateProperty.all(Colors.black),
//                 //           //
//                 //           //         overlayColor: MaterialStateProperty.resolveWith<Color?>(      //
//                 //           //               (Set<MaterialState> states) {
//                 //           //             if (states.contains(MaterialState.pressed))
//                 //           //               return Color(0xff004880); //<-- SEE HERE
//                 //           //             return null; // Defer to the widget's default.
//                 //           //           },
//                 //           //         ),
//                 //           //       ),
//                 //           //
//                 //           //     ),
//                 //           //   ),
//                 //           // ),
//                 //
//                 //           /// ... Previous Button
//                 //           // IconButton(
//                 //           //     onPressed: _isPlayerReady ? ()=> _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId)-1) % _ids.length]) : null,
//                 //           //     icon: const Icon(Icons.skip_previous, size: 32,),
//                 //           //   color: Colors.white,
//                 //           // ),
//                 //
//                 //
//                 //             /// ... Play / Pause Button
//                 //           // IconButton(
//                 //           //   onPressed: _isPlayerReady ? () {
//                 //           //     _controller.value.isPlaying ? _controller.pause() : _controller.play();
//                 //           //   } : null,
//                 //           //   icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, size: 40,),
//                 //           //   color: Colors.white,
//                 //           // ),
//                 //
//                 //
//                 //           /// ... Next Button
//                 //           // IconButton(
//                 //           //   onPressed: _isPlayerReady ? ()=> _controller.load(_ids[(_ids.indexOf(_controller.metadata.videoId)+1) % _ids.length]) : null,
//                 //           //   icon: const Icon(Icons.skip_next, size: 32,),
//                 //           //   color: Colors.white,
//                 //           // ),
//                 //
//                 //
//                 //           // Now adding a volume button and slider
//                 //
//                 //           // _space,
//                 //
//                 //           // Row(
//                 //           //   children: [
//                 //           //     IconButton(
//                 //           //         onPressed: _isPlayerReady ? () {
//                 //           //           _muted ? _controller.unMute() : _controller.mute();
//                 //           //
//                 //           //           setState(() {
//                 //           //             _muted = !_muted;
//                 //           //           });
//                 //           //
//                 //           //         } : null,
//                 //           //         icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
//                 //           //       color: Colors.white,
//                 //           //     )
//                 //           //   ],
//                 //           // ),
//                 //
//                 //           // _space,
//                 //           //
//                 //           // FullScreenButton(
//                 //           //   controller: _controller,
//                 //           //   color: Colors.white,
//                 //           // ),
//                 //
//                 //
//                 //         ],
//                 //       )
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget get _space => const SizedBox(height: 15,);
//
// }
