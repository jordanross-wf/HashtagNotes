class Tag {
  String _title;
  Tag parentTag = null;

  Tag(String title) {
    this._title = title;
  }

  Tag.withParent(String title, Tag parent) {
    this._title = title;
    this.parentTag = parent;
  }

  operator ==(Tag t) => this._title == t.title;

  String get title => this._title;

  @override
  String toString() {
    return _title;
  }

  @override
  int get hashCode => _title.hashCode;

  bool isNestedTag() {
    return parentTag == null;
  }
}
