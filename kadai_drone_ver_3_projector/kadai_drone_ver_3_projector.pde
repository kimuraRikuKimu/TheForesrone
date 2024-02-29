import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;

PImage img;

ArrayList<Brush> brushes;


void setup() {
  //size(1100, 750);
  fullScreen();
  background(255);
  minim = new Minim(this);
  player = minim.loadFile("mori1.mp3");
  player.loop();
  img = loadImage("mori1.jpg");
  brushes = new ArrayList<Brush>();
  for (int i=0; i<10; i++) {
    brushes.add(new Brush());
  }
}


void draw() {
  background(255);
  image(img, 0, 0);
  for (Brush brush : brushes) {
    brush.paint();
  }
}


void mouseClicked() {
  setup();
}


class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;

  Brush() {
    angle = random(PI/2);
    x = random(width);
    y = random(height);
    clr = color(random(140, 255), random(70, 255), random(70, 255), 200);
    components = new int[3];
    for (int i=0; i<3; i++) {
      components[i] = int(random(3, 7));
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.2, 1);

    fill(clr);
    noStroke();

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1);
      float v = random(0.85, 1.1);
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i=0; i<2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);

    if (x < 0 || x > width || y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 3 * cos(angle);
    y += 3 * sin(angle);
    angle += random(-0.2, 0.2);
  }
}

void stop() {
  minim.stop();
  super.stop();
}
