import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'dart:async';

import 'models/note.dart';
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
  static const TIMEOUT = const Duration(seconds: 2);
  static const ms = const Duration(milliseconds: 1);
  Timer saveNoteTimer;

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
        ..onFocus = _focusHandler
        ..value = state.noteText != null ? state.noteText : ''
        ..isDisabled = state.noteText == null)()),
      (BlockContent()
        ..shrink = true)((Button()..onClick = _saveNoteText)('Save')),
    ));
  }

  void _updateNoteText(SyntheticFormEvent event) {
    var noteText = event.target.value;
    setState(newState()..noteText = noteText);

    if (saveNoteTimer != null && saveNoteTimer.isActive) {
      saveNoteTimer.cancel();
    }
    saveNoteTimer = startTimeout();
  }

  void _saveNoteText(_) {
    var modifiedNote = props.activeNote.change(text: state.noteText);
    modifiedNote.updateNoteHashtags();
    props.actions.editNote(modifiedNote);
  }

  void _focusHandler(SyntheticFocusEvent event) {
    //Seems to only handle focus gained events
  }

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? TIMEOUT : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    _saveNoteText(null);
    print('Autosaving Note');
  }
}
