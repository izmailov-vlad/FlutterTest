class User {
  Name name;
  Location location;
  Picture picture;

  User({required this.name, required this.location, required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: Name.fromJson(json['name']),
        location: Location.fromJson(json['location']),
        picture: Picture.fromJson(json['picture']));
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({required this.first, required this.last, required this.title});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
      title: json['title'],
    );
  }
}

class Picture {
  String large;

  Picture({required this.large});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(large: json['large']);
  }
}

class Location {
  Street street;
  String city;
  String state;

  Location({required this.city, required this.state, required this.street});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        city: json['city'],
        state: json['state'],
        street: Street.fromJson(json['street']));
  }
}

class Street {
  int number;
  String name;

  Street({required this.number, required this.name});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(name: json['name'], number: json['number']);
  }
}
