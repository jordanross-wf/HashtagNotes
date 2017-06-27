import 'Tag.dart';

class Note {
  String text;
  String id;
  Set<Tag> noteHashtags = new Set();

  Note({String this.text, String this.id: '1a'});

  Note change({String text, String id}) {
    String rText = text != null ? text : this.text;
    String rId = id != null ? id : this.id;

    return new Note(text: rText, id: rId);
  }

  Set<Tag> getTags() {
    return noteHashtags;
  }

  void updateNoteHashtags() {
    RegExp exp = new RegExp(r"(#\w+) ");
    Iterable<Match> matches = exp.allMatches(text);

    Set<Tag> newTagSet = new Set();

    for (var hashtagMatch in matches) {
      Tag newTag = new Tag(hashtagMatch.group(0).trim());

      if (newTagSet.add(newTag)) {
        print("Added tag to set");
      }
    }

    if (noteHashtags != newTagSet) {
      noteHashtags = newTagSet;
      /* Also update global tags by union.
        Need to eventually account for removing tags from global as well, since
        this will handle local by default but not global */
    }

    noteHashtags.forEach((tag) => print(tag.title));
  }
}
