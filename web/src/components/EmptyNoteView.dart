import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'models/Note.dart';

@Factory()
UiFactory<EmptyNoteProps> EmptyNoteView;

@Props()
class EmptyNoteProps extends UiProps{
  var createNote;
}

@State()
class EmptyNoteState extends UiState{
  String noteText;
}

@Component()
class EmptyNoteComponent extends UiStatefulComponent<EmptyNoteProps, EmptyNoteState>{
  dynamic handleCreateNote(String text) {
    var note = new Note(text: text);
    if (this.props.createNote != null) {
      this.props.createNote(note);
    }
  }

  @override
  render(){
    return (
        (EmptyView()
          ..header = 'No Notes Found'
        )(
            (Button()
              ..onClick = _createEmptyNote
            )('Create a new note')
        )
    );
  }

  void _createEmptyNote(_) {
    this.props.createNote(new Note(text: "My first note!"));
  }
}