class Note {
  String _text;

  Note(String text) {
    this._text = text;
  }

  String get text => this._text;

  List<String> getTags(){
    return [""];
  }

  void setText(String text) {
    this._text = text;
  }
}
