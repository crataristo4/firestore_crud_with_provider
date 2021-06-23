class Books {
  final id;
  final title;
  final desc;

  Books({this.id, this.title, this.desc});

  Map<String, dynamic> bookToMap() {
    return {'id': id, 'title': title, 'desc': desc};
  }

  Books.fromFireStore(Map<String, dynamic> bookData)
      : id = bookData['id'],
        title = bookData['title'],
        desc = bookData['desc'];
}
