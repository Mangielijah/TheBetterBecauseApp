import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_better_because/constants.dart';
import 'package:the_better_because/models/story.model.dart';
import 'package:the_better_because/screens/stories.screen.dart';

class StoryScreen extends StatelessWidget {
  final Story story;
  const StoryScreen({Key key, this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(story.author);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          Constants.story,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
              child: CachedNetworkImage(
                imageUrl: story.photo,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.softLight),
                    ),
                  ),
                ),
                placeholder: (context, url) => Loading(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: (MediaQuery.of(context).size.height / 4) * 3 - 70,
              left: 20,
              child: Container(
                color: Colors.black26,
                padding: EdgeInsets.all(8),
                child: Text(
                  story.author.replaceFirst("By ", ""),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: (MediaQuery.of(context).size.height / 4) * 3 - 75,
                width: MediaQuery.of(context).size.width - 20,
                child: Card(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
                      child: Text(
                        story.text,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.3
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
