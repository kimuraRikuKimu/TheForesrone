import hypermedia.net.*;
import processing.serial.*;

Serial serial;
UDP udp;

int ard_data;//アルディーノの値を読み込むための変数。
int ard_atai;//連続して同じ値をとる事を防止する為に使った変数。 値は植物1つにつき1個増えて、大体-1～10くらいの数の予定（初期設定の1000は除く）
int ard_count;//連続して同じ値をとってきたときに時間経過で初期化してもう一回同じ値が入力することが出来る

int drone_count; //ドローンの入力がされたらカウントが0になる。されてない時にカウントが増えるようにする変数

String ip = "192.168.10.1";
int port = 8889;

float x;
float y;
float z;

int r;
float theta;

int fi;
int fn;

int n;
int t;
int lockN;

boolean stop;

void setup() {
  size(500, 500, P3D);
  udp = new UDP(this, 8888);
  udp.listen(true);
  udp.send("command", ip, port);


  serial = new Serial(this, "COM7", 115200);

  x = 0;
  y = 0;
  z = 0;

  r=1;
  theta = 0;

  fi = 0;
  fn = 0;

  n = 0;
  t = 0;
  lockN = 0;

  ard_data = 1000;//アルディーノの連続して同じ値が送られるのをふせぐためのコードを書く際に初期設定として必要。
  ard_atai = 1001;
  ard_count = 0;


  stop = false;
}

void draw() {

  if (ard_data == ard_atai || ard_count < 30) {
    ard_data = 1000;
    ard_atai = 1001;
  } else if (ard_data != ard_atai || ard_count == 30) { //同じ値じゃない時、または同じ値でもカウント（値をとってからの時間）が一定数（時間）超えたらもう一回同じ値を取ることが出来る
    ard_atai = ard_data;
    ard_count = 0;
  }


  if (stop == false) {
    background(0, 0, 0);

    /*
    ard_atai = int(map(ard_data, 0, 255, 0, 100)); //0から255だったのが0から100にする！
     */

    translate(width/2, height/2, 0);
    rotateX(radians(90));
    push();
    //床ここから
    translate(0, -1000, -(height*9/10-(height/2)));
    beginShape();
    fill(#FF7F50);
    noStroke();
    //vertex(0, height*9/10, 0);
    //vertex(width, height*9/10, 0);
    //vertex(width, height*9/10+10, 0);
    //vertex(0, height*9/10+10, 0);
    //endShape();

    box(width*2, 2200, -1);
    //ここまで


    //  pushMatrix();

    pop();



    fill(255);
    strokeWeight(5);
    stroke(80, 100, 200);


    translate(x, y, z);
    rotate(radians(theta));



    //ボックスを書くぜ！ここから
    //box(100, 100, 100);

    beginShape(QUADS);

    //正面
    fill(255, 255, 255);
    vertex(-50, 50, 50);
    vertex( 50, 50, 50);
    vertex( 50, -50, 50);
    vertex(-50, -50, 50);
    //前
    fill(255, 0, 0);
    vertex( 50, 50, 50);
    vertex( 50, 50, -50);
    vertex( 50, -50, -50);
    vertex( 50, -50, 50);
    //裏
    fill(255, 255, 255);
    vertex( 50, 50, -50);
    vertex(-50, 50, -50);
    vertex(-50, -50, -50);
    vertex( 50, -50, -50);
    //後ろ
    fill(0, 0, 255);
    vertex(-50, 50, -50);
    vertex(-50, 50, 50);
    vertex(-50, -50, 50);
    vertex(-50, -50, -50);
    //横
    fill(255, 255, 255);
    vertex(-50, 50, -50);
    vertex( 50, 50, -50);
    vertex( 50, 50, 50);
    vertex(-50, 50, 50);
    //横
    fill(255, 255, 255);
    vertex(-50, -50, -50);
    vertex( 50, -50, -50);
    vertex( 50, -50, 50);
    vertex(-50, -50, 50);

    endShape();

    //ここまで！


    if (t == 0 ||( n%10 != 0 && lockN%2 == 0)) {
      line(50, 0, 150, 0);
      line(149, 0, 130, -20);
      line(149, 0, 130, 20);
    }





    //touchセンサーで動く

    //離陸
    if (ard_atai == 0) {
      udp.send("takeoff", ip, port);
    }




    //前進
    if (ard_atai == 1) {
      udp.send("forward 50", ip, port);
    }

    //後退
    if (ard_atai == 2) {
      udp.send("back 50", ip, port);
    }




    //アップ
    if (ard_atai == 3) {
      udp.send("up 50", ip, port);
    }

    //ダウン
    if (ard_atai == 4) {
      udp.send("down 50", ip, port);
    }



    // 左回り
    if (ard_atai == 5) {
      udp.send("ccw 50", ip, port);
    }

    //右回り
    if (ard_atai == 6) {
      udp.send("cw 50", ip, port);
    }



    //左へ
    if (ard_atai == 7) {
      udp.send("left 50", ip, port);
    }

    //右へ
    if (ard_atai == 8) {
      udp.send("right 50", ip, port);
    }

    //// 宙返り(出来なかった)
    //if (ard_atai == 9) {
    //  udp.send("flip 50", ip, port);
    //}



    ////緊急停止2
    if (ard_atai == 99) {
      udp.send("land", ip, port);
      stop = true;
    }





    //パソコンのキーで動く
    if (keyPressed) {
      //離陸
      if (keyCode == ENTER) {
        udp.send("takeoff", ip, port);
      }

      //前進
      if (key == 'w') {
        udp.send("forward 50", ip, port);
      }

      //後退
      if (key == 's') {
        udp.send("back 50", ip, port);
      }

      //ダウン
      if (key == 'd') {
        udp.send("down 50", ip, port);
      }

      //アップ
      if (key == 'a') {
        udp.send("up 50", ip, port);
      }

      // 左回り
      if (key == 'o') {
        udp.send("ccw 50", ip, port);
      }
      if (key == 'p') {
        udp.send("cw 50", ip, port);
      }

      //左へ
      if (key == 'q') {
        udp.send("left 50", ip, port);
      }
      //右へ
      if (key == 'e') {
        udp.send("right 50", ip, port);
      }

      ////宙返り(出来なかった)
      //if (key == 'y') {
      //  udp.send("flip 50", ip, port);
      //}

      //緊急停止
      if (keyCode == CONTROL) {
        udp.send("emergency", ip, port);
        stop = true;
      }
      ////緊急停止2
      if (keyCode == SHIFT) {
        udp.send("land", ip, port);
        stop = true;
      }
    }
  }
  print(ard_data);
  print("   ");
  print(ard_atai);
  print("   ");
  println(ard_count);
}



void serialEvent(Serial p) { //何か送られてきたら作動する

  ard_data = p.read();//でも送られてきたけど読み込みしなきゃ意味がない

  ard_count ++ ;  //アルディーノからデータが送られてきたらカウントする
}


//void ard_atai_seigyo(ard_atai) {
//}
