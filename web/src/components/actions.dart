import 'package:w_flux/w_flux.dart';
import 'models/Note.dart' show Note;

class NoteActions {
  final Action<Note> createNote = new Action<Note>();
  final Action<Note> editNote = new Action<Note>();
  final Action<Note> deleteNote = new Action<Note>();
  final Action<Note> changeActiveNote = new Action<Note>();
}