import 'package:w_flux/w_flux.dart';
import 'actions.dart';
import 'models/note.dart';
import 'models/tag.dart';

class NoteStore extends Store {
  final NoteActions _actions;

  Map<String, Note> _notesMap = {};
  Map<Tag, Set<Note>> _tagMap = {};
  String _activeNoteId;
  Set<Tag> _activeTags = new Set();

  NoteStore(NoteActions actions) : _actions = actions {
    triggerOnAction(_actions.createNote, _createNote);
    triggerOnAction(_actions.editNote, _editNote);
    triggerOnAction(_actions.deleteNote, _deleteNote);
    triggerOnAction(_actions.changeActiveNote, _changeActiveNote);
    triggerOnAction(_actions.selectTag, _selectTag);
    triggerOnAction(_actions.deselectTag, _deselectTag);
    triggerOnAction(_actions.toggleTag, _toggleTag);
  }

  Note get activeNote => _notesMap[_activeNoteId];

  List<Note> get notes {
    List<Note> notes = [];
    for (var note in _notesMap.values) {
      var unionSet = note.noteHashtags.intersection(_activeTags);
      if (_activeTags.length == 0 || unionSet.length > 0) {
        notes.add(note);
      }
    }

    return []..addAll(notes.reversed);
  }

  Set<Tag> get activeTags => _activeTags;

  List<Tag> get tags {
    List<Tag> tags = [];
    for (var tag in _tagMap.keys) {
      tags.add(tag);
    }

    return []..addAll(tags.reversed);
  }

  _createNote(Note note) {
    if (note == null) {
      note = new Note();
    }
    _notesMap[note.id] = note;
  }

  _editNote(Note note) {
    if (note == null) {
      if (_activeNoteId == null) {
        return;
      }

      note = _notesMap[_activeNoteId];
    }
    _notesMap[note.id] = note;
    for (Tag tag in note.noteHashtags) {
      if (!_tagMap.containsKey(tag)) {
        _tagMap[tag] = new Set<Note>();
      }

      _tagMap[tag].add(note);
    }

    for (Tag tag in note.removedNoteHashtags) {
      if (_tagMap.containsKey(tag)) {
        if (_tagMap[tag].contains(note)) {
          _tagMap[tag].remove(note);
        }

        if (_tagMap[tag].length == 0) {
          _tagMap.remove(tag);
        }
      }
    }

    note.removedNoteHashtags = new Set();
  }

  _deleteNote(Note note) {
    _notesMap.remove(note.id);
  }

  _changeActiveNote(Note note) {
    _activeNoteId = note != null ? note.id : null;
  }

  _selectTag(Tag tag) {
    _activeTags.add(tag);
  }

  _deselectTag(Tag tag) {
    _activeTags.remove(tag);
  }

  _toggleTag(Tag tag) {
    if (_activeTags.contains(tag)) {
      _activeTags.remove(tag);
    } else {
      _activeTags.add(tag);
    }
  }

  bool hasNotes() {
    return _notesMap.length > 0;
  }
}
