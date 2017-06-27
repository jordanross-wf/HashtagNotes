import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import 'actions.dart';
import 'models/Tag.dart';

@Factory()
UiFactory<TagListProps> TagList;

@Props()
class TagListProps extends UiProps {
  List<Tag> tags;
  NoteActions actions;
  Tag activeTag;
}

@Component()
class TagListComponent extends UiComponent<TagListProps> {
  @override
  render() {
    return ((Nav()
      ..type = NavType.PILLS
      ..isStacked = true
      ..style = {'maxWidth': '30rem'})(renderTags()));
  }

  List renderTags() {
    if (props != null && props.tags != null) {
      List tagList = [];

      for (Tag tagItem in props.tags) {
        var navItem = (NavItem()..key = tagItem.title)(tagItem.title);
        tagList.add(navItem);
      }

      print('Should be rendering tagList: ${props.tags}');
      return tagList;
    }
  }
}
