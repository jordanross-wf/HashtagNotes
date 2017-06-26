import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'models/Note.dart';
import 'actions.dart';

@Factory()
UiFactory<EmptyNoteProps> EmptyNoteView;

@Props()
class EmptyNoteProps extends UiProps{
  NoteActions actions;
}

@State()
class EmptyNoteState extends UiState{
  String noteText;
}

@Component()
class EmptyNoteComponent extends UiStatefulComponent<EmptyNoteProps, EmptyNoteState>{
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
    if (props.actions != null) {
      props.actions.createNote(new Note(text: 'My first note!'));
    }
  }
}