import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'TagList.dart';
import 'NoteArea.dart';
import 'NoteList.dart';
import 'Note.dart';
import 'EmptyNoteView.dart';

@Factory()
UiFactory<AppProps> App;

@Props()
class AppProps extends UiProps{

}

@State()
class AppState extends UiState{
  List<Note> notes;
  Note activeNote;
}

@Component()
class AppComponent extends UiStatefulComponent<AppProps, AppState>{
  @override
  Map getInitialState() => (newState()
    ..notes = []
  );

  dynamic createNote(Note newNote) {
    if (newNote != null) {
      print('created new note!');
      var activeNote = state.activeNote;
      if (activeNote == null) {
        activeNote = newNote;
      }
      print('activeNote should now be $activeNote');

      this.setState(
          newState()
            ..notes = (new List.from(state.notes)..add(newNote))
            ..activeNote = activeNote
      );
    }
  }

  dynamic saveNote(Note note, String text) {
    if (note != null) {
      print('saved note!');
      note.setText(text);
      this.setState(
          newState()
            ..notes = new List.from(state.notes)
            ..activeNote = note
      );
    } else {
      print('tried to save null note?');
    }
  }

  dynamic changeActiveNote(int noteIndex) {
    if (noteIndex != null && noteIndex >= 0 && noteIndex < state.notes.length) {
      Note note = state.notes[noteIndex];
      if (note != null) {
        print('changed active note!');
        this.setState(
            newState()
              ..notes = new List.from(state.notes)
              ..activeNote = note
        );
      } else {
        print('note was null when pulled from state');
      }
    } else {
      var length = state.notes.length;
      print('could not change active note, index was $noteIndex, and length is $length');
    }
  }

  @override
  render(){
    return (Dom.div())(
        Dom.h1()("Das Notas"),
        renderNoteContent()
    );
  }

  dynamic renderNoteContent() {
    if (state.notes.isNotEmpty) {
      return Block()(
        (BlockContent()
          ..shrink = true)(
            TagList()()
        ),
        (BlockContent()
          ..collapse = BlockCollapse.HORIZONTAL
          ..shrink = true
        )(
            (NoteList()
              ..notes = this.state.notes
              ..changeActiveNote = changeActiveNote
              ..createNote = createNote
            )()
        ),
        (Block()..wrap = true)(
            (NoteArea()
              ..activeNote = state.activeNote
              ..updateNote = saveNote
            )()
        ),
      );
    } else {
      return (EmptyNoteView()
        ..createNote = createNote
      )();
    }
  }
  
  void _createEmptyNote(_) {
    createNote(new Note(''));
  }
}