import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'tag_list.dart';
import 'note_area.dart';
import 'note_list.dart';
import 'empty_note_view.dart';
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
    return (VBlock()..isNested = false)(
        (BlockContent()
          ..align = BlockAlign.CENTER
          ..shrink = true)(
          (Dom.h1())('Hashtag Notes!'),
        ),
        renderNoteContent());
  }

  dynamic renderNoteContent() {
    if (props.store != null && props.store.notes.isNotEmpty) {
      return (Block()..overflow = true)(
        (BlockContent()..shrink = true)((TagList()
          ..tags = props.store.tags
          ..activeTags = props.store.activeTags
          ..actions = props.actions)()),
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
