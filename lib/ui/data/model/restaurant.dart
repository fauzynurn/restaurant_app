import 'package:restaurant_app/ui/data/model/stuff.dart';

class Restaurant {
  String id;
  String name;
  String url;
  double rating;
  String desc;
  String city;
  Menu menu;

  Restaurant(this.id, this.name, this.url, this.rating, this.desc, this.city,
      this.menu);

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    url = json["pictureId"];
    rating = double.parse(json["rating"].toString());
    desc = json["description"];
    city = json["city"];
    menu = Menu.fromJson(json['menus']);
  }
}

class Menu {
  List<Stuff> foods;
  List<Stuff> drinks;

  Menu(this.foods, this.drinks);

  Menu.fromJson(Map<String, dynamic> json) {
    foods =
        (json['foods'] as List).map((item) => Stuff.fromJson(item)).toList();
    drinks =
        (json['drinks'] as List).map((item) => Stuff.fromJson(item)).toList();
  }
}
