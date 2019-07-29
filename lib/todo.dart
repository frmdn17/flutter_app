
class Todo {
  int id;
  String name;
  String overview;

  Todo(this.id, this.name, this.overview);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'overview': overview,
    };
    return map;
  }
  Todo.fromMap(Map<String , dynamic> map){
    id = map['id'];
    name = map['name'];
    overview = map['overview'];
  }
}