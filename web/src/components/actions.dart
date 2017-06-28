import 'package:w_flux/w_flux.dart';
import 'models/note.dart' show Note;
import 'models/tag.dart' show Tag;

class NoteActions {
  final Action<Note> createNote = new Action<Note>();
  final Action<Note> editNote = new Action<Note>();
  final Action<Note> deleteNote = new Action<Note>();
  final Action<Note> changeActiveNote = new Action<Note>();
  final Action<Tag> selectTag = new Action<Tag>();
  final Action<Tag> deselectTag = new Action<Tag>();
  final Action<Tag> toggleTag = new Action<Tag>();
}
