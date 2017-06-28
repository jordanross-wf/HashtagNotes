import 'tag.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class Note {
  String text;
  String id;
  Set<Tag> noteHashtags = new Set();
  Set<Tag> removedNoteHashtags = new Set();

  Note({String text, String id}) {
    this.text = text != null ? text : '';
    if (id != null) {
      this.id = id;
    } else {
      var uuid = new Uuid();
      this.id = uuid.v4();
    }
  }

  Note change({String text, String id}) {
    String rText = text != null ? text : this.text;
    String rId = id != null ? id : this.id;

    this.text = rText;
    this.id = rId;
    return this;
  }

  operator ==(Note n) => this.id == n.id;

  Set<Tag> getTags() {
    return noteHashtags;
  }

  void updateNoteHashtags() {
    RegExp exp = new RegExp(r"(#\w+)");
    Iterable<Match> matches = exp.allMatches(text);

    Set<Tag> newTagSet = new Set();

    for (var hashtagMatch in matches) {
      Tag newTag = new Tag(hashtagMatch.group(0).trim());

      newTagSet.add(newTag);
    }
    var se = const SetEquality();
    if (!se.equals(noteHashtags, newTagSet)) {
      removedNoteHashtags.addAll(noteHashtags.difference(newTagSet));
      noteHashtags = newTagSet;
      /* Also update global tags by union.
        Need to eventually account for removing tags from global as well, since
        this will handle local by default but not global */
    }
  }

  @override
  String toString() {
    return id;
  }
}
