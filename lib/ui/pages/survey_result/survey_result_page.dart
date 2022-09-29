import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';
import './survey_result.dart';

class SurveyResultPage extends StatelessWidget {
  final SurveyResultPresenter presenter;

  const SurveyResultPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: Builder(builder: (context) {
        presenter.loadData();
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                  padding: EdgeInsets.only(
                    top: 40,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withAlpha(90)),
                  child: Text('Qual seu framework web favorito?'));
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                  child: Row(
                    children: [
                      Image.network(
                        '',
                        width: 40,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'React',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                      Text(
                        '100%',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.check_circle,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            );
          },
          itemCount: 4,
        );
      }),
    );
  }
}
