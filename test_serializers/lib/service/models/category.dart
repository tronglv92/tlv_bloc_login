class Category{
  final int id;
  final String name;
  final String description;
  final int position;
  Category({this.id,this.name,this.description,this.position});
  factory Category.fromJson(Map<String, dynamic> parsedJson) {

    return new Category(
      id: parsedJson['id'],

      name: parsedJson['name'],
      description: parsedJson['description'],
      position: parsedJson['position'],
    );
  }
}