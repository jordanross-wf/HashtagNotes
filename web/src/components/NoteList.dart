import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'models/Note.dart';
import 'dart:math';
import 'actions.dart';

@Factory()
UiFactory<NoteListProps> NoteList;

@Props()
class NoteListProps extends UiProps{
  List<Note> notes;
  NoteActions actions;
  Note activeNote;
}

@Component()
class NoteListComponent extends UiComponent<NoteListProps>{
  @override
  render(){
    return (
        (ListGroup()
          ..isBordered = true
          ..style = {'maxWidth': '30rem'}
          ..size = ListGroupSize.LARGE
        )(
            renderNotes()
        )
    );
  }

  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);

    if (nextProps.containsKey('NoteListProps.activeNote')) {
      Note nextNote = nextProps['NoteListProps.activeNote'];
    }
  }

  List renderNotes() {
    List notes = [];
    if (this.props.notes.isNotEmpty) {
      int index = 0;
      for (var note in props.notes) {
        var noteText = note.text;
        var previewEnd = min(14, noteText.length);
        var previewText = noteText.substring(0, previewEnd);

        var listItem = (ListGroupItem()
          ..key = index
          ..targetKey = index++
          ..onSelect = _handleListSelect
          ..isActive = note == props.activeNote
        )(previewText);
        notes.add(listItem);
      }

      notes.add((ListGroupItem()
        ..key = -1
        ..targetKey = -1
        ..onSelect = _handleListSelect
      )('Create New Note'));

      return notes;
    }

    return null;
  }

  void _handleListSelect(SyntheticMouseEvent event, Object targetKey) {
    if (targetKey == -1) {
      props.actions.createNote(new Note(text: 'A new note!'));
    } else {
      Note note = props.notes[targetKey];
      props.actions.changeActiveNote(note);
    }
  }
}