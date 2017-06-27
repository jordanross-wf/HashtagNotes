import 'dart:core';
import 'dart:html';
import 'package:react/react_client.dart' show setClientConfiguration;
import 'package:react/react_dom.dart' as react_dom;
import 'components/app.dart';

import 'package:web_skin_dart/ui_components.dart';

import 'package:hotkey/hotkey.dart' as hotkey;

import 'components/actions.dart' show NoteActions;
import 'components/store.dart' show NoteStore;

void main() {
  decorateRootNodeWithPlatformClasses(features: getWebSkinFeatures());

  //Initialize React within our Dart App:
  setClientConfiguration();

  var _actions = new NoteActions();
  var _store = new NoteStore(_actions);

  hotkey.add('CTRL+N', () => _actions.createNote());
  hotkey.add('CTRL+S', () => _actions.editNote());
  hotkey.enable();

  react_dom.render(
      (App()
        ..className = "SimpleApp"
        ..actions = _actions
        ..store = _store)(),
      querySelector('#container'));
}
