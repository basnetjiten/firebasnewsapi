class Source {
  dynamic id;
  String name;

  Source.fromJSON(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
