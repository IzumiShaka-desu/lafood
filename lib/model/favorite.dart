import 'dart:convert';

List<Favorite> favoriteFromJson(String str) => List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
    Favorite({
        this.idUser,
        this.idFood,
    });

    String idUser;
    String idFood;

    factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        idUser: json["id_user"],
        idFood: json["id_food"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_food": idFood,
    };
}
