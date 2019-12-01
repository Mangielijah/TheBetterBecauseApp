import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:the_better_because/constants.dart';
import 'package:the_better_because/models/story.model.dart';

class BetterBecauseScraper {
  final BaseClient httpClient = Client();

  Future postScraper(String postUrl) async {

    Response response = await httpClient.get(postUrl);
    var body = parse(response.body);
    //List<Map<String, dynamic>> storiesJsonArray = [];
    List<Story> storiesArray = [];
    List<Element> stories = body.querySelectorAll('div.story');
    for (var story in stories) {
      String photo = story.querySelector('div.image.tint > img').attributes['src'];
      String author = story.querySelector('div.anon > p').text;
      String date = story.querySelector('div.date > p').text;
      String excerpt = _truncateWithEllipsis(200, story.querySelector('div.storySection > p').text);
      String text = story.querySelector('div.storySection > p').text;
      String link = Constants.baseUrl + story.querySelector('div.storyLink > p > a').attributes['href'];

      storiesArray.add(
        new Story(
          author: author,
          photo: photo,
          except: excerpt,
          date: date,
          link: link,
          text: text,
        )
      );}
      /*storiesJsonArray.add({
        'author': author,
        'date': date,
        'photo': photo,
        'except': excerpt,
        'link': link
      });
      return jsonEncode(storiesJsonArray);
      */
      return storiesArray;
  }

  String _truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
}
