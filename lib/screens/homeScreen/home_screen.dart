import 'dart:convert';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_class_tube/data_module.dart';
import 'package:yellow_class_tube/multiManager/flick_multi_manager.dart';
import 'package:yellow_class_tube/screens/homeScreen/widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home_screen.dart";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Video> videos = [];
  FlickMultiManager flickMultiManager;
  readJson() async {
    final String response = await rootBundle.loadString("assets/dataset.json");
    final data = await jsonDecode(response);
    for (int i = 0; i < data.length; i++) {
      videos.add(Video(data[i]["id"], data[i]["title"], data[i]["videoUrl"],
          data[i]["coverPicture"]));
    }
    flickMultiManager = FlickMultiManager();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: 100.0,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text(
                  "Yellow Class",
                  style: TextStyle(
                      fontFamily: "Splash",
                      color: Color.fromRGBO(255, 201, 31, 1),
                      fontSize: 15.0),
                ),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.cast), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.notifications_outlined), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              CircleAvatar(
                foregroundImage: AssetImage(
                  "assets/YCSmile.png",
                ),
              ),
            ],
          ),
          if (videos.isNotEmpty)
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return VisibilityDetector(
                  key: ObjectKey(flickMultiManager),
                  onVisibilityChanged: (visibility) {
                    if (visibility.visibleFraction == 0 && this.mounted) {
                      flickMultiManager.pause();
                    }
                  },
                  child: VideoCard(videos[index], flickMultiManager));
            }, childCount: videos.length))
        ],
      ),
    );
  }
}
