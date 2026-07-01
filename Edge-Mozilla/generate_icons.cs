using System;
using System.Drawing;
using System.Drawing.Drawing2D;
public static class IconGen {
  public static void Create(string path, int size) {
    using(var bmp = new Bitmap(size,size)) {
      using(var g = Graphics.FromImage(bmp)) {
        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.Clear(Color.Transparent);
        float radius = size*0.18f;
        // rounded rect path
        GraphicsPath pathRect = RoundedRect(0,0,size,size,radius);
        using(var brush = new SolidBrush(Color.FromArgb(255,255,0,0))) { g.FillPath(brush,pathRect); }
        // play triangle on left
        PointF p1 = new PointF(size*0.24f, size*0.33f);
        PointF p2 = new PointF(size*0.24f, size*0.66f);
        PointF p3 = new PointF(size*0.55f, size*0.5f);
        using(var brushW = new SolidBrush(Color.White)) { g.FillPolygon(brushW, new PointF[]{p1,p2,p3}); }
        // vertical rectangle on right (shorts)
        float rectH = size*0.7f;
        float rectW = rectH*9f/16f;
        float rectX = size*0.65f;
        float rectY = (size-rectH)/2f;
        using(var brushRect = new SolidBrush(Color.White)) { g.FillRectangle(brushRect, rectX, rectY, rectW, rectH); }
        // diagonal slash across rect (red)
        using(var pen = new Pen(Color.FromArgb(255,200,0,0), Math.Max(1f,size*0.06f))) {
           g.DrawLine(pen, rectX, rectY+rectH, rectX+rectW, rectY);
        }
        // small banned red circle over rectangle
        float circleR = rectW*0.7f;
        float cx = rectX + rectW*0.5f;
        float cy = rectY + rectH*0.18f;
        using(var brushRed = new SolidBrush(Color.FromArgb(255,220,20,20))) {
           g.FillEllipse(brushRed, cx-circleR/2f, cy-circleR/2f, circleR, circleR);
        }
        // white slash inside circle
        using(var pen2 = new Pen(Color.White, Math.Max(1f,size*0.08f))) {
           g.DrawLine(pen2, cx-circleR*0.28f, cy+circleR*0.28f, cx+circleR*0.28f, cy-circleR*0.28f);
        }
        bmp.Save(path, System.Drawing.Imaging.ImageFormat.Png);
      }
    }
  }
  public static GraphicsPath RoundedRect(float x, float y, float width, float height, float radius) {
    GraphicsPath path = new GraphicsPath();
    float diameter = radius*2f;
    if (diameter>width) diameter=width;
    if (diameter>height) diameter=height;
    path.AddArc(x, y, diameter, diameter, 180, 90);
    path.AddArc(x+width-diameter, y, diameter, diameter, 270, 90);
    path.AddArc(x+width-diameter, y+height-diameter, diameter, diameter, 0, 90);
    path.AddArc(x, y+height-diameter, diameter, diameter, 90, 90);
    path.CloseFigure();
    return path;
  }
}
