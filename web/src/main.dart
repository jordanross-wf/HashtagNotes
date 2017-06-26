import 'dart:core';
import 'dart:html';
import 'package:react/react_client.dart' show setClientConfiguration;
import 'package:react/react_dom.dart' as react_dom;
import 'components/app.dart';

import 'components/actions.dart' show NoteActions;
import 'components/store.dart' show NoteStore;

void main(){
  //Initialize React within our Dart App:
  setClientConfiguration();

  var actions = new NoteActions();
  var store = new NoteStore(actions);
  react_dom.render(
      (App()
        ..className="SimpleApp"
        ..actions = actions
        ..store = store
      )(),
      querySelector('#container'));
}