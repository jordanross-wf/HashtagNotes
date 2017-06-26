import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'models/Note.dart';

@Factory()
UiFactory<NoteAreaProps> NoteArea;

@Props()
class NoteAreaProps extends UiProps{
  Note activeNote;
  var updateNote;
}

@State()
class NoteAreaState extends UiState {
  String noteText;
}

@Component()
class NoteAreaComponent extends UiStatefulComponent<NoteAreaProps, NoteAreaState>{
  @override
  Map getInitialState() {
    if (props.activeNote != null) {
      return (
          newState()
            ..noteText = props.activeNote.text
      );
    } else {
      return (
        newState()
          ..noteText = "error: null active note"
      );
    }
  }

  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);

    if (nextProps.containsKey('NoteAreaProps.activeNote')) {
      Note nextNote = nextProps['NoteAreaProps.activeNote'];
      setState(newState()..noteText = nextNote.text);
    }
  }

  @override
  render(){
    return (
      VBlock()(
        (BlockContent()..shrink = true)(
          (AutosizeTextarea()
            ..label = 'Note'
            ..hideLabel = true
            ..placeholder = 'Type Here'
            ..onChange = _updateNoteText
            ..value = state.noteText
          )()
        ),
        (BlockContent()..shrink = true)(
          (Button()
            ..onClick = _saveNoteText
          )('Save')
        ),
      )
    );
  }

  void _updateNoteText(SyntheticFormEvent event) {
    setState(newState()..noteText = event.target.value);
  }

  void _saveNoteText(_) {
    props.updateNote(props.activeNote, state.noteText);
  }
}