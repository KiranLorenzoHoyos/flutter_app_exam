import 'package:flutter/material.dart';
import 'package:flutter_app_exam/firstscreen/FirstPresenter.dart';
import 'package:flutter_app_exam/firstscreen/FirstView.dart';
import 'package:flutter_app_exam/secondscreen/SecondScreen.dart';
import 'package:flutter_app_exam/model/Question.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> implements FirstView {
  FirstPresenter _firstPresenter;
  List<Question> _questions = [];
  bool _isLoading = true;
  bool _isError = false;

  _FirstScreenState() {
    _firstPresenter = FirstPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _firstPresenter.fetchData();
  }

  @override
  openSecondScreen(int position) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return SecondScreen(position);
    }));
  }

  @override
  showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  showError() {
    setState(() {
      _isError = true;
    });
  }

  @override
  showQuestions(List<Question> questions) {
    setState(() {
      this._questions = questions;
    });
  }

  buildBody() {
    if (_isLoading) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: CircularProgressIndicator(),
          ));
    }
    else if (_isError) {
      return Center(child: Text("Ha habido un error"));
    } else {
      return RefreshIndicator(
        onRefresh: () {
          _firstPresenter.fetchData();
        },
        child: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              leading: Icon(Icons.account_circle),
              title:
              Text(_questions[position].question),
              onTap: () {
                _firstPresenter.elementClicked(position);
              },
            );
          },
          itemCount: _questions.length,
          reverse: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter App"),),
      body: buildBody(),
    );
  }
}
