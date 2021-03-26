class Ramen{

  int id;
  String name;
  double latitude = 0.0;
  double longitude = 0.0;

  Ramen({
    this.id,
    this.name,
    this.latitude = 0.0,
    this.longitude = 0.0
  });

   factory Ramen.fromJson(Map<String, dynamic> json) => Ramen(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
    };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  Ramen.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }
}