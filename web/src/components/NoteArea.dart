import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'models/Note.dart';
import 'actions.dart';

@Factory()
UiFactory<NoteAreaProps> NoteArea;

@Props()
class NoteAreaProps extends UiProps {
  Note activeNote;
  NoteActions actions;
}

@State()
class NoteAreaState extends UiState {
  String noteText;
}

@Component()
class NoteAreaComponent
    extends UiStatefulComponent<NoteAreaProps, NoteAreaState> {
  @override
  Map getInitialState() {
    if (props.activeNote != null) {
      return (newState()..noteText = props.activeNote.text);
    } else {
      return (newState()..noteText = null);
    }
  }

  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);

    if (nextProps.containsKey('NoteAreaProps.activeNote')) {
      Note nextNote = nextProps['NoteAreaProps.activeNote'];
      setState(newState()..noteText = nextNote != null ? nextNote.text : null);
    }
  }

  @override
  render() {
    return (VBlock()(
      (BlockContent()
        ..shrink = true
        ..collapse = BlockCollapse.BOTTOM)((AutosizeTextarea()
        ..label = 'Note'
        ..hideLabel = true
        ..placeholder = 'Type Here'
        ..onChange = _updateNoteText
        ..value = state.noteText != null ? state.noteText : ''
        ..isDisabled = state.noteText == null)()),
      (BlockContent()
        ..shrink = true)((Button()..onClick = _saveNoteText)('Save')),
    ));
  }

  void _updateNoteText(SyntheticFormEvent event) {
    var noteText = event.target.value;
    setState(newState()..noteText = noteText);
  }

  void _saveNoteText(_) {
    var modifiedNote = props.activeNote.change(text: state.noteText);
    modifiedNote.updateNoteHashtags();
    props.actions.editNote(modifiedNote);
  }
}
