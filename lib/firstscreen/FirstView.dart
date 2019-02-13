import 'package:flutter_app_exam/model/Question.dart';

abstract class FirstView {
  openSecondScreen(int position);

  showQuestions(List<Question> questions);

  showLoading();

  hideLoading();

  showError();
}