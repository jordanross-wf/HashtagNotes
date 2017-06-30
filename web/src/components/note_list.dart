import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'models/note.dart';
import 'dart:math';
import 'actions.dart';
import 'dart:html';
import 'package:hotkey/hotkey.dart' as hotkey;

@Factory()
UiFactory<NoteListProps> NoteList;

@Props()
class NoteListProps extends UiProps {
  List<Note> notes;
  NoteActions actions;
  Note activeNote;
}

@State()
class NoteListState extends UiState {
  String searchTerm;
}

@Component()
class NoteListComponent extends UiStatefulComponent<NoteListProps, NoteListState> {
  @override
  Map getInitialState() {
    return (newState()..searchTerm = '');
  }

  @override
  render() {
    hotkey.add('ctrl+f', focusSearch);
    return ((VBlock()..isNested = false)(
        (SearchInput()
          ..id = 'searchfield'
          ..label = 'Notes Search'
          ..hideLabel = true
          ..onChange = _handleSearchValueChanged
        )(),
        (ListGroup()
          ..isBordered = true
          ..style = {'maxWidth': '30rem'}
          ..size = ListGroupSize.LARGE)(renderNotes()
        ),
        (Button()
          ..onClick = (_) {
            props.actions.createNote(new Note(text: 'A new note!'));
          })('Create New Note')));
  }

  List renderNotes() {
    List notes = [];
    if (this.props.notes.isNotEmpty) {
      int index = 0;
      for (var note in props.notes) {
        var noteText = note.text;
        var previewEnd = min(14, noteText.length);
        var previewText = noteText.substring(0, previewEnd);
        previewText = previewText.isEmpty ? 'Untitled' : previewText;

        var listItem = (ListGroupItem()
          ..key = index
          ..targetKey = index++
          ..onSelect = _handleListSelect
          ..isActive = note == props.activeNote)(previewText);

        if (state.searchTerm.isNotEmpty && !note.text.contains(state.searchTerm)){
          continue;
        }
        notes.add(listItem);
      }
      return notes;
    }

    return null;
  }

  void focusSearch (){
    querySelector('#searchfield').focus();
  }

  void _handleSearchValueChanged(SyntheticFormEvent event) {
    //Perform search/filter
    setState(newState()..searchTerm = event.target.value);
  }

  void _handleListSelect(SyntheticMouseEvent event, Object targetKey) {
    int targetKeyIndex = targetKey;
    if (targetKeyIndex >= 0 && targetKeyIndex < props.notes.length) {
      Note note = props.notes[targetKeyIndex];
      props.actions.changeActiveNote(note);
    }
  }
}
