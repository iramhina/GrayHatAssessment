import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCalling extends StatefulWidget {
  const VideoCalling({super.key});

  @override
  State<StatefulWidget> createState() {
    return VideoCallingState();
  }
}

const appId = "3ac990ffad3d45f0b3f677d3adcc8124";
const token =
    "007eJxTYHC69lW4p+BFWouibtPNUqtpbG7zbLXSa5z7qoJ2Mr6o4FdgME5MtrQ0SEtLTDFOMTFNM0gyTjMzN08xTkxJTrYwNDJZcnt+akMgI4PHkVhmRgYIBPHZGdKLEiszEksYGABWuR/1";

class VideoCallingState extends State<VideoCalling> {
  final agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: appId, channelName: "grayhat", tempToken: token));

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await agoraClient.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text("VideoCall"),
      ),
      body: SafeArea(child: Stack(children: [
        AgoraVideoViewer(client: agoraClient, 
        layoutType: Layout.floating,
        showNumberOfUsers: false,
        ), 
        AgoraVideoButtons(client: agoraClient, 
      enabledButtons:const [
        BuiltInButtons.toggleCamera,
        BuiltInButtons.callEnd, 
        BuiltInButtons.toggleMic,

      ],),
      ],)),
    );
  }
}
