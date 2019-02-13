import 'package:flutter/material.dart';
import 'package:flutter_app_exam/secondscreen/SecondPresenter.dart';
import 'package:flutter_app_exam/secondscreen/SecondView.dart';
import 'package:flutter_app_exam/firstscreen/FirstScreen.dart';
import 'package:flutter_app_exam/model/Answers.dart';

class SecondScreen extends StatefulWidget {
  final int position;
  SecondScreen(this.position);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> implements SecondView {
  SecondPresenter _secondPresenter;
  List<Answers> _answers = [];
  bool _isLoading = true;
  bool _isError = false;

  _SecondScreenState() {
    _secondPresenter = SecondPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _secondPresenter.fetchData();
  }

  @override
  openFirstScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return FirstScreen();
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
  showAnswers(List<Answers> answers) {
    setState(() {
      this._answers = answers;
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
          _secondPresenter.fetchData();
          print("Entra");
        },
        child: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              leading: Icon(Icons.account_circle),
              title:
              Text(_answers[position].correct_answer),
              onTap: () {
                _secondPresenter.elementClicked();
              },
            );
          },
          itemCount: _answers.length,
          reverse: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}
