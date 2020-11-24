class Stuff {
  String name;

  Stuff(this.name);

  Stuff.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
