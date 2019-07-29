import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'Post.dart';
import 'PostsScreen.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateUpdateScreen extends StatefulWidget {
  Post post;

  CreateUpdateScreen({this.post});

  @override
  State<StatefulWidget> createState() => _CreateUpdateScreen();

}

class _CreateUpdateScreen extends State<CreateUpdateScreen> {
  bool isLoading = false;
  ApiService apiService = ApiService();
  bool idValid;
  bool titleValid;
  bool bodyValid;
  bool userIdValid;
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if(widget.post != null){
      titleValid = true;
      titleController.text = widget.post.title;
      idValid = true;
      idController.text = widget.post.id.toString();
      bodyValid = true;
      bodyController.text = widget.post.body;
      userIdValid = true;
      userIdController.text = widget.post.userId.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? "Add Post" : "Update Post",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFieldTitle(),
                TextFieldId(),
                TextFieldBody(),
                TextFieldUserId(),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.post == null
                          ? "Add Post".toUpperCase()
                          : "Update Post".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (titleValid == null || bodyValid == null || userIdValid == null ||
                          !titleValid || !bodyValid ||
                          !userIdValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Field Can't Be EMPTY"),
                          ),
                        );
                        return;
                      }
                      setState(() => isLoading = true);
                      String title = titleController.text
                          .toString();
                      String body = bodyController.text.toString();
                      int userId = int.parse(
                          userIdController.text.toString());
                      Post post = Post(
                          title: title,
                          body: body,
                          userId: userId);

                      if (widget.post == null) {
                        apiService.addPosts(post).then((isSuccess) {
                          setState(() => isLoading = false);
                          if (isSuccess) {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new PostsScreen()));
                          print("Success Add");return showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                content: Text("Post Added"),
                              );
                            },
                          );
                          } else {
                            _scaffoldState.currentState
                                .showSnackBar(SnackBar(
                              content: Text("Failed To Save Post"),
                            ));
                          }
                        });
                      } else {
                        post.id = widget.post.id;
                        apiService.updPosts(post).then((isSuccess) {
                          setState(() => isLoading = false);
                          if (isSuccess) {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new PostsScreen()));
                            print("Succes Update");
                            return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    content: Text("Post Updated!"),
                                  );
                                },
                            );
                          } else {
                            _scaffoldState.currentState
                                .showSnackBar(SnackBar(
                                content: Text(
                                    "Failed To Update Data")
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  } Widget TextFieldId(){
    return TextField(
      enabled: false,
      controller: idController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "ID",
      ),
    );
  }
  Widget TextFieldTitle(){
    return TextField(
      controller: titleController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Title",
        errorText: titleValid == null || titleValid ? null : "Title Required",
      ),
      onChanged: (value){
        bool FieldValid = value.trim().isNotEmpty;
        if(FieldValid != titleValid){
          setState(() => titleValid = FieldValid);
        }
      },
    );
  }


  Widget TextFieldUserId(){
    return TextField(
      controller: userIdController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "User Id",
        errorText: userIdValid == null || userIdValid ? null : "Title Required",
      ),
      onChanged: (value){
        bool FieldValid = value.trim().isNotEmpty;
        if(FieldValid != userIdValid){
          setState(() => userIdValid = FieldValid);
        }
      },
    );
  }
  Widget TextFieldBody(){
    return TextField(
      controller: bodyController,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: "Overview",
        errorText: bodyValid == null || bodyValid ? null : "Overview Required",
      ),
      onChanged: (value){
        bool FieldValid = value.trim().isNotEmpty;
        if(FieldValid != bodyValid){
          setState(() => bodyValid = FieldValid);
        }
      },
    );
  }
}