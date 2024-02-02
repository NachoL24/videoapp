// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print

import 'package:camera/camera.dart';
// import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter_full/return_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:screen_recorder/screen_recorder.dart';
//import 'package:video_app/examples/video_con_timer.dart';
import 'package:video_app/providers/countdown_provider.dart';
import 'package:video_app/providers/countup_provider.dart';
import 'package:video_app/providers/tabata_provider.dart';
import 'package:video_app/screens/timer_screen.dart';
import 'package:video_app/screens/video_screen.dart';
//import 'package:screen_recorder/screen_recorder.dart';
//import 'package:render/render.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.timerType});
  final TimerType timerType;

  @override
  CameraPageState createState() => CameraPageState();
}

enum WidgetState {none, loading, loaded, error}

class CameraPageState extends State<CameraPage> {
  bool _isRecording = false;
  WidgetState widgetState = WidgetState.none;
  late CameraController _cameraController;
  Offset? _focusPoint;
  bool _isFlashOn = false;
  // final renderController = RenderController();
  
  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    widgetState = WidgetState.loading;
    final cameras = await availableCameras();
    final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(back, ResolutionPreset.max);
    await _cameraController.initialize();
    //setState(() => _isLoading = false);
    if (_cameraController.value.hasError) {
      widgetState = WidgetState.error;
      if (mounted) setState(() {});
    } else {
      widgetState = WidgetState.loaded;
      if (mounted) setState(() {});
    }
  }

  _recordVideo() async {
    if (_isRecording == false) {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    } else {
      
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(file: file),
      );
      Navigator.push(context, route);
    }
  }

  void _switchCamera() async {
    final cameras = await availableCameras();
    
    if (_cameraController != null){
      await _cameraController.dispose();
    }
    if (_cameraController.description.lensDirection == CameraLensDirection.back) {
      _cameraController = CameraController(cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front), ResolutionPreset.max);
    }else{
      _cameraController = CameraController(cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back), ResolutionPreset.max);
      _isFlashOn = false;
    }
    await _cameraController.initialize();
    if (_cameraController.value.hasError) {
      widgetState = WidgetState.error;
      if (mounted) setState(() {});
    } else {
      widgetState = WidgetState.loaded;
      if (mounted) setState(() {});
    }
  }

  Future<void> _setFocusPoint (Offset point) async {
    if (_cameraController.value != null && _cameraController.value.isInitialized){
      try {
        final double x = point.dx.clamp(0.0, 1.0);
        final double y = point.dy.clamp(0.0, 1.0);
        await _cameraController.setFocusPoint(Offset (x, y));
        await _cameraController.setFocusMode(FocusMode.locked);
        setState(() {
          _focusPoint = Offset(x,y);
        });

        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          _focusPoint = null;
        });
      } catch (e){
        print("Error de focus point: $e");
      }
    }
  }

void _toogleFlash() {
    if(_isFlashOn) {
      _cameraController.setFlashMode(FlashMode.off);
      _isFlashOn = false;
    }else{
      _cameraController.setFlashMode(FlashMode.torch);
      _isFlashOn = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountDownProvider>(context);
    final countupProvider = Provider.of<CountupProvider>(context);
    final tabataProvider = Provider.of<TabataProvider>(context);
    switch (widgetState) {
      case WidgetState.none:
      case WidgetState.loading:
        return buildScaffold(context, const Text('Iniciando camara...'));
      case WidgetState.loaded:
        return SafeArea(
          child: Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // 
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                            ),
                          ),
                          if (_cameraController.description.lensDirection == CameraLensDirection.back)
                            Padding(
                              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () async{
                                  _toogleFlash();
                                },
                                child: Icon(
                                  _isFlashOn == true
                                    ? Icons.flash_on  //implementar opcion para cambiar de icono de flash
                                    : Icons.flash_off, 
                                  color: Colors.white,),
                              ),
                            ),
                        ],
                      )
                    )
                  ),
                  //

                  Positioned.fill(
                    top: 50,
                    child: AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details){
                          final Offset tapPosition = details.localPosition;
                          final Offset relativTapPosition = Offset(
                            tapPosition.dx / constraints.maxWidth,
                            tapPosition.dy / constraints.maxHeight,
                          );
                          _setFocusPoint(relativTapPosition);
                        },
                        child: CameraPreview(_cameraController,
                          child:
                            Positioned(
                              top: 0,
                              right: 10,
                              child: Container(
                                color: Colors.transparent,
                                child: Text( widget.timerType != TimerType.tabata 
                                    ? (widget.timerType == TimerType.countdown
                                      ? context.select((CountDownProvider count) => count.timeLeftString)
                                      : context.select((CountupProvider count) => count.timeLeftString)) 
                                    : context.select((TabataProvider count) => count.timeLeftString), 
                                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.normal, color: Colors.white),),
                              ),
                            ),
                        ),
                      ),
                    ),
                  ),
                  
                 /* Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      color: Colors.transparent,
                      child: Text( widget.timerType != TimerType.tabata 
                          ? (widget.timerType == TimerType.countdown
                            ? context.select((CountDownProvider count) => count.timeLeftString)
                            : context.select((CountupProvider count) => count.timeLeftString)) 
                          : context.select((TabataProvider count) => count.timeLeftString), 
                        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.normal, color: Colors.white),),
                    ),
                  ),*/
                  
                  if(_focusPoint != null)
                  Positioned.fill(
                    top: 80,
                    child: Align(
                      alignment: Alignment(_focusPoint!.dx * 2 - 1, _focusPoint!.dy * 2 - 1),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20)
                        ),
                      )
                    ),
                  ),

                  
                      
                  Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: IconButton(
                          icon: Icon(_isRecording ? Icons.stop : Icons.circle, color: _isRecording ? Colors.black : Colors.red), iconSize: 75,
                          onPressed: ()  {
                            switch (widget.timerType){
                                case TimerType.countdown:
                                  countdownProvider.startStopTimer();
                                  break;
                                case TimerType.countup:
                                  countupProvider.startStopTimer();
                                  break;
                                case TimerType.tabata:
                                  tabataProvider.startStopTimer();
                                  break;
                              }
                            _recordVideo();
                          },
                        ),
                      ),
                  ),
                      
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25, right: 25),
                        child: IconButton(icon: const Icon(Icons.cameraswitch), iconSize: 50,onPressed: () { _switchCamera(); },),
                      )
                    ),
                ],
              );
              },
            ),
          ),
        );
      case WidgetState.error:
        return buildScaffold(context, const Text("¡Ooops! Error al cargar la cámara 😩. Reinicia la apliación."));
    }}

    Widget buildScaffold(BuildContext context, Text text) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cámara"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(widgetState == WidgetState.loading)
                            const CircularProgressIndicator(),
                          text
                        ],
                      ),
            ),
    );
    }


    
}
