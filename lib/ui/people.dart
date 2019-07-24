class People {
  String name;

  People({this.name});

  factory People.fromJson(Map<String, dynamic> peopleJson){
    return People(
      name: peopleJson['name'],
    );
  }
}