int c0;  //緊急停止
int c1;  //離陸
int c2;  //前進
int c3;  //後退
int c4;  //アップ
int c5;  //ダウン
int c6;  //左回転
int c7;  //右回転
int c8;  //左へ
int c9;  //右へ


void setup() {
  // シリアル通信設定
  Serial.begin(115200);
  // 2番ピン設定(離陸)
  pinMode(2, OUTPUT);  // ディジタル出力
  // 3番ピン設定
  pinMode(3, INPUT);  // ディジタル入力


  // 4番ピン設定（前進）
  pinMode(4, OUTPUT);  // ディジタル出力
  // 5番ピン設定
  pinMode(5, INPUT);  // ディジタル入力



  // 6番ピン設定(後退)
  pinMode(6, OUTPUT);  // ディジタル出力
  // 7番ピン設定
  pinMode(7, INPUT);  // ディジタル入力



  // 8番ピン設定(アップ)
  pinMode(8, OUTPUT);  // ディジタル出力
  // 9番ピン設定
  pinMode(9, INPUT);  // ディジタル入力



  // 11番ピン設定(緊急停止)
  pinMode(11, OUTPUT);  // ディジタル出力
  // 12番ピン設定
  pinMode(12, INPUT);  // ディジタル入力



  // 22番ピン設定(ダウン)
  pinMode(22, OUTPUT);  // ディジタル出力
  // 24番ピン設定
  pinMode(24, INPUT);  // ディジタル入力



  // 26番ピン設定(左回転)
  pinMode(26, OUTPUT);  // ディジタル出力
  // 28番ピン設定
  pinMode(28, INPUT);  // ディジタル入力


  // 30番ピン設定(右回転)
  pinMode(30, OUTPUT);  // ディジタル出力
  // 32番ピン設定
  pinMode(32, INPUT);  // ディジタル入力


  // 34番ピン設定(左)
  pinMode(47, OUTPUT);  // ディジタル出力
  // 36番ピン設定
  pinMode(49, INPUT);  // ディジタル入力


  // 38番ピン設定(右)
  pinMode(51, OUTPUT);  // ディジタル出力
  // 40番ピン設定
  pinMode(53, INPUT);  // ディジタル入力

  // 13番ピン設定(LED)
  pinMode(13, OUTPUT);
}

void loop() {
  // カウンタ変数の初期化
  c0 = 0;  //緊急停止
  c1 = 0;  //離陸
  c2 = 0;  //前進
  c3 = 0;  //後退
  c4 = 0;  //アップ
  c5 = 0;  //ダウン
  c6 = 0;  //左回転
  c7 = 0;  //右回転
  c8 = 0;  //左
  c9 = 0;  //右


  // 8番ピンをHIGHに変化させる

  digitalWrite(11, HIGH);  //11から12に電気が流れる
  digitalWrite(2, HIGH);   //2から3に電気が流れる
  digitalWrite(4, HIGH);   //4から5に電気が流れる
  digitalWrite(6, HIGH);   //6から7に電気が流れる
  digitalWrite(8, HIGH);   //8から9に電気が流れる
  digitalWrite(22, HIGH);  //22から24に電気が流れる
  digitalWrite(26, HIGH);  //26から28に電気が流れる
  digitalWrite(30, HIGH);  //30から32に電気が流れる
  digitalWrite(47, HIGH);  //47から49に電気が流れる
  digitalWrite(51, HIGH);  //51から53に電気が流れる



  while (digitalRead(12) != HIGH) {
    // カウントアップ
    c0++;
  }

  while (digitalRead(3) != HIGH) {
    // カウントアップ
    c1++;
  }

  while (digitalRead(5) != HIGH) {
    // カウントアップ
    c2++;
  }

  while (digitalRead(7) != HIGH) {
    // カウントアップ
    c3++;
  }

  while (digitalRead(9) != HIGH) {
    // カウントアップ
    c4++;
  }

  while (digitalRead(24) != HIGH) {
    // カウントアップ
    c5++;
  }

  while (digitalRead(28) != HIGH) {
    // カウントアップ
    c6++;
  }

  while (digitalRead(32) != HIGH) {
    // カウントアップ
    c7++;
  }

  while (digitalRead(49) != HIGH) {
    // カウントアップ
    c8++;
  }

  while (digitalRead(53) != HIGH) {
    // カウントアップ
    c9++;
  }

  // delay(500);

  // 500マイクロ秒待つ
  delayMicroseconds(500);

  //緊急停止
  if (c0 > 5) {  // 値2は必要に応じて調整してください
    // LEDを点灯
    digitalWrite(13, HIGH);
    Serial.write(99);
  } else {
    // LEDを消灯
    digitalWrite(13, LOW);
  }

  //離陸
  if (c1 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(0);
  }

  //前進
  if (c2 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(1);
  }

  //後退
  if (c3 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(2);
  }

  //アップ
  if (c4 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(3);
  }

  //ダウン
  if (c5 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(4);
  }

  //左回転
  if (c6 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(5);
  }

  //右回転
  if (c7 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(6);
  }

  //左
  if (c8 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(7);
  }

  //右
  if (c9 > 1) {  // 値2は必要に応じて調整してください
    Serial.write(8);
  }


  // 8番ピンをLOWにする
  digitalWrite(11, LOW);
  digitalWrite(2, LOW);
  digitalWrite(4, LOW);
  digitalWrite(6, LOW);
  digitalWrite(8, LOW);
  digitalWrite(22, LOW);
  digitalWrite(26, LOW);
  digitalWrite(30, LOW);
  digitalWrite(47, LOW);
  digitalWrite(51, LOW);

  // //これやるとprocessingとこのアルディーノのシリアル通信が重なってしまう
  // Serial.print("0:");
  // Serial.print(c0);
  // Serial.print(",  1:");
  // Serial.print(c1);
  // Serial.print(",  2:");
  // Serial.print(c2);
  // Serial.print(",  3:");
  // Serial.print(c3);
  // Serial.print(",  4:");
  // Serial.print(c4);
  // Serial.print(",  5:");
  // Serial.print(c5);
  // Serial.print(",  6:");
  // Serial.print(c6);
  // Serial.print(",  7:");
  // Serial.print(c7);
  // Serial.print(",  8:");
  // Serial.print(c8);
  // Serial.print(",  9:");
  // Serial.println(c9);

  // 放電するまで待つ
  delayMicroseconds(5000);
}






/* //抵抗の制御センサーのやつ
int val;

void setup() {
  Serial.begin(9600);
}

void loop(){
  val = analogRead(0);
  val = val/4;

  Serial.write(val);
  delay(300);
}

//タッチセンサー
//ピン1番がタッチされたら１、二番がタッチされたら２を返す。
*/