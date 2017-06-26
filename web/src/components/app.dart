import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'TagList.dart';
import 'NoteArea.dart';
import 'NoteList.dart';
import 'models/Note.dart';
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
      var activeNote = state.activeNote;
      if (activeNote == null) {
        activeNote = newNote;
      }

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
      note.change(text: text);
      this.setState(
          newState()
            ..notes = new List.from(state.notes)
            ..activeNote = note
      );
    }
  }

  dynamic changeActiveNote(int noteIndex) {
    if (noteIndex != null && noteIndex >= 0 && noteIndex < state.notes.length) {
      Note note = state.notes[noteIndex];
      if (note != null) {
        this.setState(
            newState()
              ..notes = new List.from(state.notes)
              ..activeNote = note
        );
      }
    }
  }

  @override
  render(){
    return (Dom.div())(
        Dom.h1()("Hashtag Notes!"),
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
    createNote(new Note(text: ''));
  }
}