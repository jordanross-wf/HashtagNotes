import 'package:w_flux/w_flux.dart';
import 'actions.dart';
import 'models/Note.dart';
import 'package:uuid/uuid.dart';

class NoteStore extends Store {
  final NoteActions _actions;

  Map<String, Note> _notesMap = {};
  String _activeNoteId;

  NoteStore(NoteActions actions)
      : _actions = actions {
    triggerOnAction(_actions.createNote, _createNote);
    triggerOnAction(_actions.editNote, _editNote);
    triggerOnAction(_actions.deleteNote, _deleteNote);
    triggerOnAction(_actions.changeActiveNote, _changeActiveNote);

//    manageActionSubscription(_actions.createNote.listen(_createNote));
//    manageActionSubscription(_actions.editNote.listen(_editNote));
//    manageActionSubscription(_actions.deleteNote.listen(_deleteNote));
//    manageActionSubscription(_actions.changeActiveNote.listen(_changeActiveNote));

    trigger();
  }

  Note get activeNote => _notesMap[_activeNoteId];
  List<Note> get notes {
    List<Note> notes = [];
    for (var note in _notesMap.values) {
      notes.add(note);
    }

    return []..addAll(notes.reversed);
  }

  _createNote(Note note) {
    var updatedIdNote = note.change(id: generateUuid());
    _notesMap[note.id] = updatedIdNote;
  }

  _editNote(Note note) {
    _notesMap[note.id] = note;
  }

  _deleteNote(Note note) {
    _notesMap.remove(note.id);
  }

  _changeActiveNote(Note note) {
    _activeNoteId = note != null ? note.id : null;
  }

  bool hasNotes() {
    return _notesMap.length > 0;
  }

  String generateUuid() {
    var uuid = new Uuid();

    return uuid.v4();
  }
}