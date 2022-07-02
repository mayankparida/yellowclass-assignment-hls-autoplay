import 'package:flutter/material.dart';
import 'package:yellow_class_tube/data_module.dart';
import 'package:yellow_class_tube/screens/homeScreen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

final selectedVideoProvider = StateProvider<Video>((ref) => null);

class LandingScreen extends StatefulWidget {
  static String id = "landing_screen.dart";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  static const double _playerMinHeight = 60.0;
  final _screenList = [
    HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text('Explore'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Add'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Subscriptions'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Library'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final selectedVideo = watch(selectedVideoProvider).state;
          return Stack(
            children: _screenList
                .asMap()
                .map(
                  (i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: _selectedIndex != i,
                      child: screen,
                    ),
                  ),
                )
                .values
                .toList()
                  ..add(Offstage(
                    offstage: selectedVideo == null,
                    child: Miniplayer(
                        maxHeight: MediaQuery.of(context).size.height,
                        minHeight: _playerMinHeight,
                        builder: (height, percentage) {
                          if (selectedVideo == null)
                            return const SizedBox.shrink();
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    selectedVideo.coverPic.toString(),
                                    height: _playerMinHeight - 4.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              selectedVideo.title.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "Yellow Class",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.play_arrow),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        context
                                            .read(selectedVideoProvider)
                                            .state = null;
                                      }),
                                ],
                              ),
                              const LinearProgressIndicator(
                                value: 1.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(255, 201, 31, 1),
                                ),
                              )
                            ],
                          );
                        }),
                  )),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: "Subscriptions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: "Home"),
        ],
      ),
    );
  }
}
