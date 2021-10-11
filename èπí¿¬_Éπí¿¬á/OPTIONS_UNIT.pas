unit OPTIONS_UNIT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Buttons, Spin, opengl, sColorSelect, sSpeedButton;

type
  TOPform = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    WIDTH1_SE: TSpinEdit;
    HEIGHT_SE: TSpinEdit;
    WIDTH2_SE: TSpinEdit;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label13: TLabel;
    ROT_V: TSpinEdit;
    ColorDialog1: TColorDialog;
    Label11: TLabel;
    SAKR_V: TSpinEdit;
    Label12: TLabel;
    GLUB: TSpinEdit;
    Label14: TLabel;
    Label15: TLabel;
    Shape1: TsColorSelect;
    Shape5: TsColorSelect;
    Shape7: TsColorSelect;
    Shape8: TsColorSelect;
    Shape6: TsColorSelect;
    Shape2: TsColorSelect;
    Shape9: TsColorSelect;
    Shape4: TsColorSelect;
    Shape3: TsColorSelect;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RadioButton1Enter(Sender: TObject);
    procedure RadioButton2Enter(Sender: TObject);
    procedure ROT_VChange(Sender: TObject);
    procedure HEIGHT_SEChange(Sender: TObject);
    procedure WIDTH2_SEChange(Sender: TObject);
    procedure WIDTH1_SEChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SAKR_VChange(Sender: TObject);
    procedure GLUBChange(Sender: TObject);
    procedure Shape1Change(Sender: TObject);
  private
    { Private declarations }
  SAVE_OPTIONS:BOOLEAN;
  //Ширина верхушки накладки //Ширина основания накладки //Высота накладки
  COL_WIDTH1_tmp,COL_WIDTH2_tmp,COL_TOP_tmp:Single;
  tik_tmp,tik2_tmp,GS_tmp:BYTE; SOUND_TMP:BOOLEAN;
  FON_tmp,COLOR_BLACK_tmp, COLOR_RED_tmp, COLOR_BLUE_tmp, COLOR_WHITE_tmp, COLOR_GREEN_tmp, COLOR_YELLOW_tmp, COLOR_ORANGE_tmp: Array [0..3] of GLfloat;
  procedure COL_to_COL(var col1:array of single;col2:array of single);
  procedure Save_tmp;procedure Load_tmp;
  procedure OP_IN_FORM;
  public
    { Public declarations }
  end;

var
  OPform: TOPform;


 implementation

uses INIT_UNIT, FRMMAIN_UNIT;

{$R *.dfm}

procedure TOPform.COL_to_COL(var col1:array of single;col2:array of single);
begin
  col1[0]:=col2[0];
  col1[1]:=col2[1];
  col1[2]:=col2[2];
end;
procedure TOPform.SAKR_VChange(Sender: TObject);
begin
  tik2:=11-SAKR_V.Value;
end;

procedure TOPform.Save_tmp;
begin
  COL_to_COL(COLOR_BLACK_tmp,COLOR_BLACK);
  COL_to_COL(COLOR_RED_tmp,COLOR_RIGHT);
  COL_to_COL(COLOR_BLUE_tmp,COLOR_FRONT);
  COL_to_COL(COLOR_WHITE_tmp,COLOR_TOP);
  COL_to_COL(COLOR_GREEN_tmp,COLOR_BACK);
  COL_to_COL(COLOR_YELLOW_tmp,COLOR_BOTTOM);
  COL_to_COL(COLOR_ORANGE_tmp,COLOR_LEFT);
  COL_to_COL(FON_tmp,FON);
  tik_tmp:=tik;
  tik2_tmp:=tik;
  GS_tmp:=GS;
  SOUND_TMP:=sound;
  COL_WIDTH1_tmp:=COL_WIDTH1; COL_WIDTH2_tmp:=COL_WIDTH2;COL_TOP_tmp:=COL_TOP;
end;
procedure TOPform.Shape1Change(Sender: TObject);
var R, G, B : GLfloat;
procedure ColorToGL (c : TColor );
begin
 R := (c mod 256) / 255;
 G := ((c div 256) mod 256) / 255;
 B := (c div 65536) / 255;
end;
begin
     ColorToGL(Tscolorselect(Sender).ColorValue);
     if Tscolorselect(Sender)=Shape8 then
        begin
        if (G=0) and (B=0) and (R<109/255) and (R>0) then
        begin
        Application.MessageBox('Данный цвет зарезервирован и '+#13#10+'не может использоваться фоном!','Внимание!',48);
        exit;
        end;
         FON[0]:=R;FON[1]:=G;FON[2]:=B;
         glClearColor (R,G, B,1);
        end;
    if Tscolorselect(Sender)=Shape7 then
        begin
         COLOR_BLACK[0]:=0.3*R;COLOR_BLACK[1]:=0.3*G;COLOR_BLACK[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape6 then
        begin
         COLOR_BOTTOM[0]:=0.3*R;COLOR_BOTTOM[1]:=0.3*G;COLOR_BOTTOM[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape5 then
        begin
         COLOR_TOP[0]:=0.3*R;COLOR_TOP[1]:=0.3*G;COLOR_TOP[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape4 then
        begin
         COLOR_LEFT[0]:=0.3*R;COLOR_LEFT[1]:=0.3*G;COLOR_LEFT[2]:=0.3*B;
        end;
    if Tscolorselect(Sender)=Shape9 then
        begin
         COLOR_mig[0]:=0.3*R;COLOR_mig[1]:=0.3*G;COLOR_mig[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape3 then
        begin
         COLOR_RIGHT[0]:=0.3*R;COLOR_RIGHT[1]:=0.3*G;COLOR_RIGHT[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape2 then
        begin
         COLOR_BACK[0]:=0.3*R;COLOR_BACK[1]:=0.3*G;COLOR_BACK[2]:=0.3*B;
        end;
      if Tscolorselect(Sender)=Shape1 then
        begin
         COLOR_FRONT[0]:=0.3*R;COLOR_FRONT[1]:=0.3*G;COLOR_FRONT[2]:=0.3*B;
        end;
     InvalidateRect(frmGL.Handle, nil, False );
end;

procedure TOPform.Load_tmp;
begin
  COL_to_COL(COLOR_BLACK,COLOR_BLACK_tmp);
  COL_to_COL(COLOR_RIGHT,COLOR_RED_tmp);
  COL_to_COL(COLOR_FRONT,COLOR_BLUE_tmp);
  COL_to_COL(COLOR_TOP,COLOR_WHITE_tmp);
  COL_to_COL(COLOR_BACK,COLOR_GREEN_tmp);
  COL_to_COL(COLOR_BOTTOM,COLOR_YELLOW_tmp);
  COL_to_COL(COLOR_LEFT,COLOR_ORANGE_tmp);
  COL_to_COL(FON,FON_tmp);
  tik:=tik_tmp;
  tik2:=tik_tmp;
  GS:=GS_tmp;
  SOUND:=sound_tmp;
  COL_WIDTH1:=COL_WIDTH1_tmp; COL_WIDTH2:=COL_WIDTH2_tmp;COL_TOP:=COL_TOP_tmp;
  glClearColor (FON[0],FON[1], FON[2],1);
  MAKE_NAKL;
end;

procedure TOPform.BitBtn1Click(Sender: TObject);
begin
with frmgl do
begin
  Shape1.Brush.Color:= RGB(round(COLOR_FRONT[0]*850),round(COLOR_FRONT[1]*850),round(COLOR_FRONT[2]*850));
  Shape2.Brush.Color:= RGB(round(COLOR_BACK[0]*850),round(COLOR_BACK[1]*850),round(COLOR_BACK[2]*850));
  Shape5.Brush.Color:= RGB(round(COLOR_TOP[0]*850),round(COLOR_TOP[1]*850),round(COLOR_TOP[2]*850));
  Shape6.Brush.Color:= RGB(round(COLOR_BOTTOM[0]*850),round(COLOR_BOTTOM[1]*850),round(COLOR_BOTTOM[2]*850));
  Shape4.Brush.Color:= RGB(round(COLOR_LEFT[0]*850),round(COLOR_LEFT[1]*850),round(COLOR_LEFT[2]*850));
  Shape3.Brush.Color:= RGB(round(COLOR_RIGHT[0]*850),round(COLOR_RIGHT[1]*850),round(COLOR_RIGHT[2]*850));
RadioButton1.Repaint;RadioButton3.Repaint;RadioButton5.Repaint; RadioButton7.Repaint;
RadioButton2.Repaint;RadioButton4.Repaint;RadioButton6.Repaint;
end;
SAVE_OPTIONS:=true;
writeoptions;
close;
end;

procedure TOPform.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TOPform.BitBtn3Click(Sender: TObject);
begin
  COL_to_COL(COLOR_BLACK,COLOR_BLACK_DEF);
  COL_to_COL(COLOR_RIGHT,COLOR_RIGHT_DEF);
  COL_to_COL(COLOR_FRONT,COLOR_FRONT_DEF);
  COL_to_COL(COLOR_TOP,COLOR_TOP_DEF);
  COL_to_COL(COLOR_BACK,COLOR_BACK_DEF);
  COL_to_COL(COLOR_BOTTOM,COLOR_BOTTOM_DEF);
  COL_to_COL(COLOR_LEFT,COLOR_LEFT_DEF);
  COL_to_COL(COLOR_MIG,MIG_DEF);
  COL_to_COL(FON,FON_DEF);
  tik:=tik_DEF;
  tik2:=tik2_DEF;
  GS:=GS_DEF;
  SOUND:=true;
  COL_WIDTH1:=COL_WIDTH1_DEF; COL_WIDTH2:=COL_WIDTH2_DEF;COL_TOP:=COL_TOP_DEF;
  OP_IN_FORM;
  glClearColor (FON_DEF[0],FON_DEF[1], FON_DEF[2],1);
   InvalidateRect(frmGL.Handle, nil, False );
end;

procedure TOPform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not(SAVE_OPTIONS) then
  begin
    Load_tmp;
    InvalidateRect(frmGL.Handle, nil, false);
  end;
  //Разлокировка меню редактирования
if frmGL.AUTO_MI.Enabled then frmgl.EDIT_CUBE_MI.Enabled:=true;
end;

procedure TOPform.OP_IN_FORM;
begin
  Shape1.ColorValue:= RGB(round(COLOR_FRONT[0]*850),round(COLOR_FRONT[1]*850),round(COLOR_FRONT[2]*850));
  Shape2.ColorValue:= RGB(round(COLOR_BACK[0]*850),round(COLOR_BACK[1]*850),round(COLOR_BACK[2]*850));
  Shape5.ColorValue:= RGB(round(COLOR_TOP[0]*850),round(COLOR_TOP[1]*850),round(COLOR_TOP[2]*850));
  Shape6.ColorValue:= RGB(round(COLOR_BOTTOM[0]*850),round(COLOR_BOTTOM[1]*850),round(COLOR_BOTTOM[2]*850));
  Shape4.ColorValue:= RGB(round(COLOR_LEFT[0]*850),round(COLOR_LEFT[1]*850),round(COLOR_LEFT[2]*850));
  Shape3.ColorValue:= RGB(round(COLOR_RIGHT[0]*850),round(COLOR_RIGHT[1]*850),round(COLOR_RIGHT[2]*850));
  Shape9.ColorValue:= RGB(round(color_mig[0]*850),round(color_mig[1]*850),round(color_mig[2]*850));
  Shape7.ColorValue:= RGB(round(color_black[0]*850),round(color_black[1]*850),round(color_black[2]*850));
  Shape8.ColorValue:= RGB(round(FON[0]*255),round(FON[1]*255),round(FON[2]*255));
  ROT_V.Value:=21-tik;
  HEIGHT_SE.Value:=round((COL_TOP-1)*100);
  WIDTH1_SE.Value:=round((COL_WIDTH1)*100);
  WIDTH2_SE.Value:=round((COL_WIDTH2)*100);
  if sound then RadioButton1.Checked:=true else  RadioButton2.Checked:=true;;
  SAVE_OPTIONS:=false;
  SAKR_V.Value:=11-tik2;
  GLUB.Value:=GS;
end;
procedure TOPform.FormShow(Sender: TObject);
begin
  OP_IN_FORM;
  //Запись текущих настроек
  Save_tmp;
  SAVE_OPTIONS:=false;
end;

procedure TOPform.GLUBChange(Sender: TObject);
begin
  GS:=GLUB.Value;
end;

procedure TOPform.HEIGHT_SEChange(Sender: TObject);
begin
  COL_TOP:=1+HEIGHT_SE.Value/100;
  MAKE_NAKL;
  InvalidateRect(frmGL.Handle, nil, False );
end;

procedure TOPform.RadioButton1Enter(Sender: TObject);
begin
sound:=true;
end;

procedure TOPform.RadioButton2Enter(Sender: TObject);
begin
sound:=false;
end;

procedure TOPform.ROT_VChange(Sender: TObject);
begin
tik:=21-ROT_V.Value;
end;

procedure TOPform.WIDTH1_SEChange(Sender: TObject);
begin
if WIDTH1_SE.Value >=1 then
  begin
    COL_WIDTH1:=WIDTH1_SE.Value/100;
    MAKE_NAKL;
    InvalidateRect(frmGL.Handle, nil, False );
  end;
end;

procedure TOPform.WIDTH2_SEChange(Sender: TObject);
begin
if WIDTH2_SE.Value >=70 then
  begin
    COL_WIDTH2:=WIDTH2_SE.Value/100;
    MAKE_NAKL;
    InvalidateRect(frmGL.Handle, nil, False );
  end;
end;

end.
