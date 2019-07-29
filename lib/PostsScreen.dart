import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'CreateUpdateScreen.dart';
import 'Post.dart';
import 'package:fluttertoast/fluttertoast.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PostsScreen extends StatefulWidget {
  Post posts;

  PostsScreen({this.posts});

  @override
  State<StatefulWidget> createState() => _PostsScreen();

}


class _PostsScreen extends State<PostsScreen> {
  BuildContext context;
  bool isLoading = false;
  bool titleValid;
  bool bodyValid;
  bool userIdValid;
  bool idValid;
  ApiService apiService = ApiService();
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Screen'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
//            _AddPost();
                Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {
                  return CreateUpdateScreen();
                }));
              },
              child: Padding(padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add, color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: new Container(
          child: FutureBuilder(
            future: apiService.getPosts(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Error : ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<Post> posts = snapshot.data;
                return _ListView(posts);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }

  Widget TextFieldId() {
    return TextField(
      enabled: false,
      controller: idController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "ID",
        errorText: idValid == null || userIdValid ? null : "ID Required",
      ),
      onChanged: (value) {
        bool FieldValid = value
            .trim()
            .isNotEmpty;
        if (FieldValid != idValid) {
          setState(() => idValid = idValid);
        }
      },
    );
  }

  Widget TextFieldTitle() {
    return TextField(
      controller: titleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Title",
        errorText: titleValid == null || titleValid ? null : "Title Required",
      ),
      onChanged: (value) {
        bool FieldValid = value
            .trim()
            .isNotEmpty;
        if (FieldValid != titleValid) {
          setState(() => titleValid = FieldValid);
        }
      },
    );
  }

  Widget TextFieldUserId() {
    return TextField(
      controller: userIdController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "User ID",
        errorText: userIdValid == null || userIdValid
            ? null
            : "User ID Required",
      ),
      onChanged: (value) {
        bool FieldValid = value
            .trim()
            .isNotEmpty;
        if (FieldValid != userIdValid) {
          setState(() => userIdValid = FieldValid);
        }
      },
    );
  }

  Widget TextFieldBody() {
    return TextField(
      controller: bodyController,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: "Overview",
        errorText: bodyValid == null || bodyValid ? null : "Overview Required",
      ),
      onChanged: (value) {
        bool FieldValid = value
            .trim()
            .isNotEmpty;
        if (FieldValid != bodyValid) {
          setState(() => bodyValid = FieldValid);
        }
      },
    );
  }


  Widget _ListView(List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Post post = posts[index];
          return Dismissible(
//              padding: const EdgeInsets.only(top: 8.0),
            key: Key(post.title),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8.0),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white, size: 96.0),
            ),
            onDismissed: (direction) {
              setState(() {
                apiService.delPosts(post.id).then((isSuccess) {
                  if (isSuccess) {
                    print("Deleted");
                    Fluttertoast.showToast(msg: "${posts[index].title} Deleted",
                     toastLength: Toast.LENGTH_SHORT);
                  } else {
                    print("Delete Failed");
                  }
                });
              });
            },
            child: Card(
                child: InkWell(
                    onTap: () {
                      _DetailPost(context, posts[index]);
                    },
                    onLongPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return CreateUpdateScreen(post: post);
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("ID : " + post.id.toString()),
                            Text(post.title, style: Theme
                                .of(context)
                                .textTheme
                                .title,
                            ),
                            Text("\nUser ID : \n" + post.userId.toString()),
                            Text("\nOverview : " + post.body,
                              overflow: TextOverflow.ellipsis, maxLines: 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    _DetailPost(context, posts[index]);
                                  },
                                  child: Text("Show Detail",
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            )
                          ]),
                    )
                )
            ),
          );
        },
        itemCount: posts.length,
      ),
    );
  }

  void _AddPost() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              alignment: Alignment.center,
              padding: new EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  TextFieldId(),
                  TextFieldTitle(),
                  TextFieldBody(),
                  TextFieldUserId(),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                        child: Text("Save Data"),
                        onPressed: () {
                          if (titleValid == null || bodyValid == null ||
                              userIdValid == null ||
                              !titleValid || !bodyValid || !userIdValid) {
                            print("Field Can't Be Empty");
                            return;
                          }
                          setState(() => isLoading = true);
                          String title = titleController.text.toString();
                          String body = titleController.text.toString();
                          int userId = int.parse(
                              userIdController.text.toString());
                          int id = int.parse(idController.text.toString());
                          Post post = Post(
                              id: id, title: title, body: body, userId: userId);
                          if (widget.posts == null) {
                            apiService.addPosts(post).then((isSuccess) {
                              setState(() => isLoading = false);
                              if (isSuccess) {
                                print("Success Add Posts");
                              } else {
                                print("Failed");
                              }
                            });
                          }
                        },
                      )
                  )
                ],
              )
          );
        }
    );
  }

  void _DetailPost(BuildContext context, Post post) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new Container(
          alignment: Alignment.center,
          padding: new EdgeInsets.all(8.0),
          child: new Column(
              children: <Widget>[
                new Text("\nID : \n",
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    )
                ),
                new Text("${post.id} \n\n",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal
                    )
                ),
                new Text("Title : \n",
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    )
                ),
                new Text("${post.title} \n\n",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal
                    )
                ),
                new Text("User ID : \n",
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    )
                ),
                new Text("${post.userId} \n\n",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal
                    )
                ),
                new Text("Overview :"
                    " \n",
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    )
                ),
                new Text("${post.body}",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal
                    )
                )
              ]
          ),
        );
      },
    );
  }
}
