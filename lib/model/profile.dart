import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Profile({
        this.idUser,
        this.email,
        this.password,
        this.nama,
        this.phone,
        this.dob,
    });

    String idUser;
    String email;
    String password;
    dynamic nama;
    String phone;
    dynamic dob;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        idUser: json["id_user"],
        email: json["email"],
        password: json["password"],
        nama: json["nama"],
        phone: json["phone"],
        dob: json["DOB"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "password": password,
        "nama": nama,
        "phone": phone,
        "DOB": dob,
    };
}
