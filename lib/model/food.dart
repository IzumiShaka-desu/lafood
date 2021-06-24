import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    Food({
        this.idFood,
        this.name,
        this.ingredients,
        this.variant,
        this.price,
        this.photo,
        this.phone,
        this.idUser,
    });

    String idFood;
    String name;
    String ingredients;
    String variant;
    String price;
    String photo;
    dynamic phone;
    String idUser;
static const BASEURLImage = 'http://192.168.43.150/images/';
  String get urlPhoto => (photo != null) ? BASEURLImage + photo : null;
    factory Food.fromJson(Map<String, dynamic> json) => Food(
        idFood: json["id_food"],
        name: json["name"],
        ingredients: json["ingredients"],
        variant: json["variant"],
        price: json["price"],
        photo: json["photo"],
        phone: json["phone"],
        idUser: json["id_user"],
    );

    Map<String, dynamic> toJson() => {
        "id_food": idFood,
        "name": name,
        "ingredients": ingredients,
        "variant": variant,
        "price": price,
        "photo": photo,
        "phone": phone,
        "id_user": idUser,
    };
}
