import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

@Factory()
UiFactory<TagListProps> TagList;

@Props()
class TagListProps extends UiProps{

}

@State()
class TagListState extends UiState{

}

@Component()
class TagListComponent extends UiStatefulComponent<TagListProps, TagListState>{
  @override
  render(){
    return (
      (Nav()
        ..type = NavType.PILLS
        ..isStacked = true
        ..style = {'maxWidth': '30rem'}
      )(
        NavItem()('#tag1'),
        NavItem()('#tag2'),
        NavItem()('#tag3'),
      )
    );
  }
}