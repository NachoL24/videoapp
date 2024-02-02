// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
// import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';



class VideoPage extends StatefulWidget {
  final XFile file;

  const VideoPage({super.key, required this.file});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  
  
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.file.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) { 
   var nameDate = DateTime.now().microsecondsSinceEpoch;
   String newName = "workout$nameDate";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview', style: TextStyle(color: Colors.white70, fontSize: 30),),
        titleTextStyle: const TextStyle(color: Colors.white70),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white70,),
            onPressed: () async {
                print("path: ${widget.file.path}");
                try {
                  const savedDirectory = "/storage/Camera_Nacho_APP/";
                  // final savedFile = '$savedDirectory/$newName.mp4';
                  // final outputPath = '$savedDirectory/$newName(1).mp4';
                  final directory = await getApplicationSupportDirectory();
                  final file = await File(widget.file.path).copy('${directory.path}/$newName.mp4');
                  await GallerySaver.saveVideo(file.path,albumName: savedDirectory);
                  
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El video se guardo correctamente'),));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El video el video no se puedo guardar, intentelo de nuevo.'),));
              }
            }
          )
        ],
        leading: IconButton(
          onPressed: () { 
            Navigator.pop(context);
           },
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white70,),

        ),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}