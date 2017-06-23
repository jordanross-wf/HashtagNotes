import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'Note.dart';
import 'dart:math';

@Factory()
UiFactory<NoteListProps> NoteList;

@Props()
class NoteListProps extends UiProps{
  List<Note> notes;
  var changeActiveNote;
  var createNote;
}

@State()
class NoteListState extends UiState{

}

@Component()
class NoteListComponent extends UiStatefulComponent<NoteListProps, NoteListState>{
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

  List renderNotes() {
    List notes = [];
    if (this.props.notes.isNotEmpty) {
      int index = 0;
      for (var note in this.props.notes) {
        var noteText = note.text;
        var previewEnd = min(14, noteText.length);
        var previewText = noteText.substring(0, previewEnd);

        var listItem = (ListGroupItem()
          ..key = index
          ..targetKey = index++
          ..onSelect = _handleListSelect
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
      props.createNote(new Note("A new note!"));
    } else {
      props.changeActiveNote(targetKey);
    }
  }
}


/*

react_dom.js:18121 Warning: setState(...):
Cannot update during an existing state transition
 (such as within `render` or another component's constructor). Render methods should
 be a pure function of props and state; constructor side-effects are an anti-pattern,
 but can be moved to `componentWillMount`.
 */