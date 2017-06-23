import 'dart:core';
import 'dart:html';
import 'package:react/react_client.dart' show setClientConfiguration;
import 'package:react/react_dom.dart' as react_dom;
import 'components/app.dart';

void main(){
  //Initialize React within our Dart App:
  setClientConfiguration();
  react_dom.render((App()..className="SimpleApp")(),querySelector('#container'));
}