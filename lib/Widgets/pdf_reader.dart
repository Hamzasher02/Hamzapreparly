import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReader extends StatefulWidget {

  final String PdfUrl;
  final String PdfTitle;

  const PdfReader({Key? key, required this.PdfUrl, required this.PdfTitle}) : super(key: key);
  @override
  State<PdfReader> createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(widget.PdfTitle),

        // actions: <Widget>[
        //   IconButton(          // this is a 'Download' as well "OPEN button"
        //       icon: Icon(
        //         Icons.download,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         // Create download functionality on press of this download icon
        //       }
        //
        //   ),
        // ],
      ),


        //the "OrientationBuilder" widget is used to detect changes in device orientation.
        // If the device orientation changes to landscape, the app's preferred orientation is set to landscape mode using "SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])";.
        //  If the device orientation changes back to portrait, the app's preferred orientation is set back to portrait mode using "SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])";
        body: SfPdfViewer.network(widget.PdfUrl),
    );
  }
}
