import 'dart:convert';

import 'package:flutter_app_exam/model/Question.dart';
import 'package:flutter_app_exam/firstscreen/FirstView.dart';
import 'package:http/http.dart' as network;

class FirstPresenter {
  FirstView _view;

  FirstPresenter(this._view);

  fetchData() async {
    _view.showLoading();
    network.Response response =
    await network.get('https://opentdb.com/api.php?amount=10');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List<Question> questions = jsonBody['results'].map<Question>((element) {
        String question = element['question'];
        return Question(question);
      }).toList();
      _view.showQuestions(questions);
    } else {
      _view.showError();
    }
    _view.hideLoading();
  }

  elementClicked(int position) {
    _view.openSecondScreen(position);
  }
}
