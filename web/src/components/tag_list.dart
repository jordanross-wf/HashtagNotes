import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'actions.dart';
import 'models/tag.dart';

@Factory()
UiFactory<TagListProps> TagList;

@Props()
class TagListProps extends UiProps {
  List<Tag> tags;
  NoteActions actions;
  Set<Tag> activeTags;
}

@Component()
class TagListComponent extends UiComponent<TagListProps> {
  @override
  render() {
    return (BlockContent()(
    Dom.h3()(
      'Tags'
    ),
    (Nav()
      ..type = NavType.PILLS
      ..className = 'tags'
      ..isStacked = true
      ..style = {'maxWidth': '30rem'})(renderTags())));
  }

  List renderTags() {
    if (props != null && props.tags != null) {
      List tagList = [];

      for (Tag tagItem in props.tags) {
        var navItem = (NavItem()
          ..key = tagItem.title
          ..targetKey = tagItem.title
          ..onSelect = _selectTag
          ..className = 'tags'
          ..skin = props.activeTags.contains(tagItem)
              ? NavItemPillSkin.ALT
              : NavItemPillSkin.DEFAULT
        )
          (tagItem.title);
        tagList.add(navItem);
      }

      return tagList;
    }
  }

  _selectTag(SyntheticEvent e, Object o) {
    String tagTitle = o;
    Tag tag = new Tag(tagTitle);
    props.actions.toggleTag(tag);
  }
}
