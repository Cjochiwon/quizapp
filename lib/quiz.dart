import 'package:flutter/material.dart';
import 'qalist.dart';


class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int qnum = 0; //문제 번호
  int qres = 0; //결과
  String inAns = ''; //텍스트 필드 입력값
  int nCorr = 0; //정답 갯수
  int nInco = 0; //오답 갯수
  

  @override
  Widget build(BuildContext context) {
    String strTemp = '';
    print(qnum);
    if(qnum < quest.length) {
      strTemp = quest[qnum];
    } else {
      strTemp = 'finish';
    }

    //문제 박스
    Container qCon = Container(
      child: Text(strTemp),
    );

    final textfd = TextEditingController(); //clear를 위해 컨트롤러 추가
    //텍스트 필드
    TextField ansField = TextField(
      controller: textfd,
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        inAns = value;
      },
      decoration: InputDecoration(labelText: "답을 입력ㄱㄱ."),
    );

    // Create button
    ElevatedButton okButton = ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, color: Colors.yellow)),
        backgroundColor: MaterialStateProperty.all(Colors.brown)
      ),
      child:( () {
        if(qnum < quest.length) {
          return Text("눌러");
        } else {
          return Text("결과는?");
        }
      }) (),
      onPressed: () {
        if(qnum < quest.length) {
          if(inAns.trim().compareTo(answer[qnum]) == 0) {
            //정답
            qres = 1;
            nCorr++;
          } else {
            //오답
            qres = 2;
            nInco++;
          }
          setState(() {
            qnum++; //문제번호 증가
            textfd.clear();
            inAns = '';
          });
        } else {
          AlertDialog dialog = AlertDialog(
            content: Text("전체 $qnum문제in 중\n답 : $nCorr\틀린답 : $nInco"));
          // Show dialog
          showDialog(context: context, builder: (BuildContext context) => dialog);
        }
      }
    );

    //처음으로(다시풀기) 버튼
    ElevatedButton reButton = ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, color: Colors.yellow)),
        backgroundColor: MaterialStateProperty.all(Colors.brown)
      ),
      child: Text("처음으로"),
      onPressed: () {
        setState(() {
            qnum = 0; //문제번호 초기화
            nCorr = 0;  //정답 갯수 초기화
            nInco = 0;  //오답 갯수 초기화
          }
        );
      }
    );

    //결과 이미지
    Image imgRes = Image.asset('asset/res$qres.png',);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("today의")),
      body: Container(
        height: 400,  //col 간격
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //col 간격 일정하게.
          children:(() {
            if(qnum < quest.length) {
              return [qCon, ansField, okButton, imgRes];
            } else {
              return [qCon, ansField, okButton, reButton, imgRes];
            }
          })(),
        )
      ),
    );
  }
}