import 'dart:convert';

import 'package:flutter_app_exam/model/Answers.dart';
import 'package:flutter_app_exam/secondscreen/SecondView.dart';
import 'package:http/http.dart' as network;

class SecondPresenter {
  SecondView _view;

  SecondPresenter(this._view);

  fetchData() async {
    _view.showLoading();
    network.Response response =
    await network.get('https://opentdb.com/api.php?amount=10');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List<Answers> answers = jsonBody['results'].map<Answers>((element) {
        String correct_answer = element['correct_answer'];
        String incorrect_answers = element['incorrect_answers'].toString();
        return Answers(correct_answer, incorrect_answers);
      }).toList();
      _view.showAnswers(answers);
    } else {
      _view.showError();
    }
    _view.hideLoading();
  }

  elementClicked() {
    _view.openFirstScreen();
  }
}
