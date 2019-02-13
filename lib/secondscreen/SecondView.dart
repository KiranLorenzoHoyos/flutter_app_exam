
import 'package:flutter_app_exam/model/Answers.dart';

abstract class SecondView {
  openFirstScreen();

  showAnswers(List<Answers> answers);

  showLoading();

  hideLoading();

  showError();
}