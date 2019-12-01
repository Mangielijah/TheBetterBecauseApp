import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:the_better_because/constants.dart';
import 'package:the_better_because/models/story.model.dart';
import 'package:the_better_because/scrapers/tbb.scraper.dart';
import 'package:the_better_because/screens/story.screen.dart';

import 'package:simple_animations/simple_animations.dart';
import 'dart:math';

class StoriesPage extends StatefulWidget {
  const StoriesPage({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<StoriesPage> {
  final BetterBecauseScraper betterBecauseScraper = BetterBecauseScraper();
  final List<Story> storyList = [];

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        title: Text(
          Constants.stories,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: storyList.length == 0
          ? new Loading()
          : Container(
              child: ListView.builder(
                itemCount: storyList.length,
                itemBuilder: (context, int pos) {
                  return _buildStory(pos);
                },
              ),
            ),
    );
  }

  _loadStories() async {
    final list = await betterBecauseScraper.postScraper(Constants.storiesApi);
    setState(() {
      storyList.addAll(list);
      print(storyList);
    });
  }

  Widget _buildStory(int index) {
    final story = storyList[index];
    print(storyList[index].photo);
    return Card(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: CachedNetworkImage(
              imageUrl: story.photo,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.softLight),
                  ),
                ),
              ),
              placeholder: (context, url) => new Loading(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  story.author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  story.except,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                        child: Text(
                          "Read more",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                        textColor: Colors.white,
                        color: Colors.black,
                        onPressed: () => _viewStory(story),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 28,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _viewStory(Story story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryScreen(
          story: story,
        ),
      ),
    );
  }

  /*static Widget buildAnimation() {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      duration: tween.duration,
      tween: tween,
      builder: (context, animation) {
        return Transform.rotate(
          angle: animation["rotation"],
          child: Container(
            color: Colors.white,
            child: Image.asset('images/logo.png'),
            width: animation["size"],
            height: animation["size"],
          ),
        );
      },
    );
  }*/
}

class Loading extends StatelessWidget {
  Loading({
    Key key,
  }) : super(key: key);
  final tween = MultiTrackTween([
    Track("size").add(Duration(seconds: 3), Tween(begin: 50.0, end: 100.0)),
    Track("rotation").add(Duration(seconds: 1), ConstantTween(0.0)).add(
        Duration(seconds: 4), Tween(begin: 0.0, end: 2 * pi),
        curve: Curves.easeOutSine)
  ]);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ControlledAnimation(
          playback: Playback.MIRROR,
          duration: tween.duration,
          tween: tween,
          builder: (context, animation) {
            return Transform.rotate(
              angle: animation["rotation"],
              child: Container(
                color: Colors.white,
                child: Image.asset('images/logo.png'),
                width: animation["size"],
                height: animation["size"],
              ),
            );
          },
        ),
      ),
    );
  }
}
