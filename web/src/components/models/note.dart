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
    RegExp expAllTagLevels = new RegExp(r"(#\w+[\/\w+]*)");
    Iterable<Match> parentTagMatches = expAllTagLevels.allMatches(text);

    Set<Tag> newTagSet = new Set();

    for (var hashtagMatch in parentTagMatches) {
      Tag newTag = new Tag(hashtagMatch.group(0).trim());

      newTagSet.add(newTag);
    }

    for (var hashmatch in parentTagMatches) {
      String tagString = hashmatch.group(0);
      int slashIndex = tagString.indexOf("/");
      Tag parentTag = null;

      if (slashIndex != -1) {
        parentTag = new Tag(tagString.substring(0,slashIndex).trim());
        newTagSet.add(parentTag);
      }

      newTagSet.add(new Tag.withParent(tagString.trim(), parentTag));
    }
    var se = const SetEquality();
    if (!se.equals(noteHashtags, newTagSet)) {
      removedNoteHashtags.addAll(noteHashtags.difference(newTagSet));
      noteHashtags = newTagSet;
    }
  }

  @override
  String toString() {
    return id;
  }
}
