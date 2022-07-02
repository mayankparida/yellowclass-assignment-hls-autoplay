import 'package:flutter/material.dart';
import 'package:yellow_class_tube/data_module.dart';
import 'package:yellow_class_tube/multiManager/flick_multi_manager.dart';
import 'package:yellow_class_tube/multiManager/flick_multi_player.dart';
import 'package:yellow_class_tube/screens/landingScreen/landing_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class VideoCard extends StatelessWidget {
  Video video;
  FlickMultiManager flickMultiManager;

  VideoCard(Video video, FlickMultiManager flickMultiManager) {
    this.video = video;
    this.flickMultiManager = flickMultiManager;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(selectedVideoProvider).state = video;
      },
      child: Column(
        children: [
          Stack(
            children: [
              FlickMultiPlayer(
                url: video.videoUrl.toString(),
                flickMultiManager: flickMultiManager,
                image: video.coverPic.toString(),
              ),
              // Image.network(
              //   video.coverPic.toString(),
              //   height: 200.0,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              // Positioned(
              //   bottom: 8.0,
              //   right: 8.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.black.withOpacity(0.8),
              //         borderRadius: BorderRadius.circular(5.0)),
              //     padding: EdgeInsets.all(5.0),
              //     child: Text(
              //       "17:18",
              //       style: Theme.of(context)
              //           .textTheme
              //           .caption
              //           .copyWith(color: Colors.white),
              //     ),
              //   ),
              // )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  // backgroundColor: Colors.white,
                  foregroundImage: AssetImage("assets/YCLogo.jpg"),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          video.title.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 15.0),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Yellow Class \u2022 12K Views \u2022 1 day ago",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  size: 20.0,
                )
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Color.fromRGBO(66, 66, 66, 1),
            thickness: 5.0,
          )
        ],
      ),
    );
  }
}
