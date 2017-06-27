import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'TagList.dart';
import 'NoteArea.dart';
import 'NoteList.dart';
import 'EmptyNoteView.dart';
import 'actions.dart' show NoteActions;
import 'store.dart' show NoteStore;

@Factory()
UiFactory<AppProps> App;

@Props()
class AppProps extends FluxUiProps<NoteActions, NoteStore> {}

@Component()
class AppComponent extends FluxUiComponent<AppProps> {
  @override
  getDefaultProps() => (newProps());

  @override
  render() {
    return (Dom.div())(Dom.h1()("Hashtag Notes!"), renderNoteContent());
  }

  dynamic renderNoteContent() {
    if (props.store != null && props.store.notes.isNotEmpty) {
      var activeNote = props.store.activeNote;
      return Block()(
        (BlockContent()..shrink = true)(TagList()()),
        (BlockContent()
          ..collapse = BlockCollapse.HORIZONTAL
          ..shrink = true)((NoteList()
          ..notes = props.store.notes
          ..actions = props.actions
          ..activeNote = props.store.activeNote)()),
        (Block()..wrap = true)((NoteArea()
          ..activeNote = props.store.activeNote
          ..actions = props.actions)()),
      );
    } else {
      return (EmptyNoteView()..actions = props.actions)();
    }
  }
}
