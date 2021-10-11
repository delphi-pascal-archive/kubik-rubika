//������������� �������� ����������
unit INIT_UNIT;
interface
uses  forms,Windows,OpenGL,sysutils,IniFiles,Classes,FRMMAIN_UNIT ;
//���������� � ������ �� 27 ���������
type
  Telement = record

  elem:byte;//������� ������ �� �������� �����������
  FRONT,BACK,LEFT,RIGHT,TOP,BOTTOM:Pointer;//����� ������ ���������
  //����� ���������� ��������� (����� ������)
  FRONT_ACTIVE,BACK_ACTIVE,LEFT_ACTIVE,RIGHT_ACTIVE,TOP_ACTIVE,BOTTOM_ACTIVE:boolean;
end;
type
  TKubik = array [-1..1,-1..1,-1..1] of Telement;
type
   //������� ���������
  Tmas = array of byte;
procedure INIT;//��������� �������������
procedure BLACK_CUBE;//׸���� ��� - ������ ��������
procedure MAKE_ID_CUBE; //ID-���
procedure MAKE_NAKL; //������� ��������
procedure KUBIK_DEFAULT;//������������� ����� ������ 27 ���������
procedure writeoptions; //������ ��������
procedure readoptions; //���������� ��������

var
//���� ��������� ����� ��� ������� ��������� ��������
 mig:boolean=false;
 edit_mode:boolean=false;//����� �������������� ������
  //���� ������� ������ �����\�����
  nnext,bback:boolean;
  //���� ����������
  //auto_mode:boolean;
    //������� ���������
  rotates_mas,auto_rotates_mas: Tmas;
  //�������� ������ ������
  KUBIK,EDIT_KUBIK:TKubik;
  //���������� ��� �������������� ������ ����
  EDIT_EL:POINTER;
  //����� ������
  COLOR_MIG,FON,COLOR_BLACK, COLOR_RIGHT, COLOR_FRONT, COLOR_TOP, COLOR_BACK, COLOR_BOTTOM, COLOR_LEFT: Array [0..3] of GLfloat;
  //������ �������� �������� //������ ��������� �������� //������ ��������
  COL_WIDTH1,COL_WIDTH2,COL_TOP:GLfloat;
  tik,tik2,GS,active_tik:byte;
  sound:boolean;
  mas_index:integer=0;
  //��� ��������
  ROTATE_MODE:BYTE=0;
  //���� ��������
   Angle : GLfloat=0;
   //���� ����� ���������\����������
   ROT_FLAG:BOOLEAN=true;
   //���� ������� ���������� �������� � ������� ���������
   NEXT_ROTATE:BOOLEAN=false;
const
  //����� ������������ �������� (1-27 - ��������)
  NAKL_LEFT : GLuint = 28;
  NAKL_RIGHT: GLuint = 29;
  NAKL_TOP : GLuint = 30;
  NAKL_BOTTOM : GLuint = 31;
  NAKL_FRONT : GLuint = 32;
  NAKL_BACK : GLuint = 33;
  CUBE : GLuint = 34;
  ID_CUBE:GLuint = 35;
  //������ �������� ��������
  COL_WIDTH1_DEF:GLfloat=0.7;
  //������ ��������� ��������
  COL_WIDTH2_DEF:GLfloat=0.9;

  //����������� ���������
  COL_TOP_DEF:GLfloat=1.1;tik_DEF:integer=5;tik2_DEF:integer=1;GS_DEF:integer=12;
  ZOOM:GLfloat=0.4;SMESH:GLFLOAT = 0.03;
  COLOR_BLACK_DEF : Array [0..3] of GLfloat = (0.01,0.01, 0.01, 1.0);
  COLOR_LEFT_DEF : Array [0..3] of GLfloat = (0.3, 0.0, 0.0, 3.0);
  COLOR_FRONT_DEF : Array [0..3] of GLfloat = (0.0, 0.0, 0.3, 1.0);
  COLOR_TOP_DEF : Array [0..3] of GLfloat = (0.3, 0.3, 0.3, 1.0);
  COLOR_BACK_DEF : Array [0..3] of GLfloat = (0, 0.3, 0, 1.0);
  COLOR_BOTTOM_DEF : Array [0..3] of GLfloat = (0.3, 0.3, 0, 1.0);
  COLOR_RIGHT_DEF : Array [0..3] of GLfloat = (0.3, 0.1, 0, 1.0);
  FON_DEF: ARRAY [0..3] of GLfloat=   (0.75,0.75,  0.75,1);
  MIG_DEF: ARRAY [0..3] of GLfloat=  (0.3, 0.3, 0.3, 1.0);
implementation

uses SELECT_UNIT;

//������ ��������
procedure writeoptions;
var  IniFile:TIniFile;
begin
//��������� ���������� � ������ Options.ini
if not(FileExists(ExtractFilePath(Application.ExeName)+'Options.ini')) then
   Application.MessageBox('���� �������� �� ������, �������� �� ���������!','��������',48);
 IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Options.ini');
//������ ��������
iniFile.WriteFloat('COLOR','COLOR_RIGHT_R',ABS(COLOR_RIGHT[0]));
iniFile.WriteFloat('COLOR','COLOR_RIGHT_G',ABS(COLOR_RIGHT[1]));
iniFile.WriteFloat('COLOR','COLOR_RIGHT_B',ABS(COLOR_RIGHT[2]));

iniFile.WriteFloat('COLOR','COLOR_FRONT_R',ABS(COLOR_FRONT[0]));
iniFile.WriteFloat('COLOR','COLOR_FRONT_G',ABS(COLOR_FRONT[1]));
iniFile.WriteFloat('COLOR','COLOR_FRONT_B',ABS(COLOR_FRONT[2]));

iniFile.WriteFloat('COLOR','COLOR_TOP_R',ABS(COLOR_TOP[0]));
iniFile.WriteFloat('COLOR','COLOR_TOP_G',ABS(COLOR_TOP[1]));
iniFile.WriteFloat('COLOR','COLOR_TOP_B',ABS(COLOR_TOP[2]));

iniFile.WriteFloat('COLOR','COLOR_BACK_R',ABS(COLOR_BACK[0]));
iniFile.WriteFloat('COLOR','COLOR_BACK_G',ABS(COLOR_BACK[1]));
iniFile.WriteFloat('COLOR','COLOR_BACK_B',ABS(COLOR_BACK[2]));

iniFile.WriteFloat('COLOR','COLOR_BOTTOM_R',ABS(COLOR_BOTTOM[0]));
iniFile.WriteFloat('COLOR','COLOR_BOTTOM_G',ABS(COLOR_BOTTOM[1]));
iniFile.WriteFloat('COLOR','COLOR_BOTTOM_B',ABS(COLOR_BOTTOM[2]));

iniFile.WriteFloat('COLOR','COLOR_LEFT_R',ABS(COLOR_LEFT[0]));
iniFile.WriteFloat('COLOR','COLOR_LEFT_G',ABS(COLOR_LEFT[1]));
iniFile.WriteFloat('COLOR','COLOR_LEFT_B',ABS(COLOR_LEFT[2]));

iniFile.WriteFloat('COLOR','COLOR_BLACK_R',ABS(COLOR_BLACK[0]));
iniFile.WriteFloat('COLOR','COLOR_BLACK_G',ABS(COLOR_BLACK[1]));
iniFile.WriteFloat('COLOR','COLOR_BLACK_B',ABS(COLOR_BLACK[2]));

iniFile.WriteFloat('COLOR','COLOR_MIG_R',ABS(COLOR_MIG[0]));
iniFile.WriteFloat('COLOR','COLOR_MIG_G',ABS(COLOR_MIG[1]));
iniFile.WriteFloat('COLOR','COLOR_MIG_B',ABS(COLOR_MIG[2]));

iniFile.WriteFloat('COLOR','FON_R',ABS(FON[0]));
iniFile.WriteFloat('COLOR','FON_G',ABS(FON[1]));
iniFile.WriteFloat('COLOR','FON_B',ABS(FON[2]));

iniFile.WriteFloat('ADD','COL_WIDTH1',COL_WIDTH1);
iniFile.WriteFloat('ADD','COL_WIDTH2',COL_WIDTH2);
iniFile.WriteFloat('ADD','COL_TOP',COL_TOP);
iniFile.WriteInteger('ADD','tik',tik);
iniFile.WriteInteger('ADD','tik2',tik2);
iniFile.WriteInteger('ADD','GS',GS);
iniFile.WriteBool('ADD','SOUND',Sound);
IniFile.Free;
end;
//���������� �������� �� �����
procedure readoptions;
var  IniFile:TIniFile;
begin
//��������� ���������� � ������ Options.ini
if not(FileExists(ExtractFilePath(Application.ExeName)+'Options.ini')) then
   Application.MessageBox('���� �������� �� ������, ��������� �������� �� ���������!','��������',48);
 IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Options.ini');
//��������� �� �����
COLOR_RIGHT[0]:=iniFile.ReadFloat('COLOR','COLOR_RIGHT_R',COLOR_RIGHT_DEF[0]);
COLOR_RIGHT[1]:=iniFile.ReadFloat('COLOR','COLOR_RIGHT_G',COLOR_RIGHT_DEF[1]);
COLOR_RIGHT[2]:=iniFile.ReadFloat('COLOR','COLOR_RIGHT_B',COLOR_RIGHT_DEF[2]);

COLOR_FRONT[0]:=iniFile.ReadFloat('COLOR','COLOR_FRONT_R',COLOR_FRONT_DEF[0]);
COLOR_FRONT[1]:=iniFile.ReadFloat('COLOR','COLOR_FRONT_G',COLOR_FRONT_DEF[1]);
COLOR_FRONT[2]:=iniFile.ReadFloat('COLOR','COLOR_FRONT_B',COLOR_FRONT_DEF[2]);

COLOR_TOP[0]:=iniFile.ReadFloat('COLOR','COLOR_TOP_R',COLOR_TOP_DEF[0]);
COLOR_TOP[1]:=iniFile.ReadFloat('COLOR','COLOR_TOP_G',COLOR_TOP_DEF[1]);
COLOR_TOP[2]:=iniFile.ReadFloat('COLOR','COLOR_TOP_B',COLOR_TOP_DEF[2]);

COLOR_BACK[0]:=iniFile.ReadFloat('COLOR','COLOR_BACK_R',COLOR_BACK_DEF[0]);
COLOR_BACK[1]:=iniFile.ReadFloat('COLOR','COLOR_BACK_G',COLOR_BACK_DEF[1]);
COLOR_BACK[2]:=iniFile.ReadFloat('COLOR','COLOR_BACK_B',COLOR_BACK_DEF[2]);

COLOR_BOTTOM[0]:=iniFile.ReadFloat('COLOR','COLOR_BOTTOM_R',COLOR_BOTTOM_DEF[0]);
COLOR_BOTTOM[1]:=iniFile.ReadFloat('COLOR','COLOR_BOTTOM_G',COLOR_BOTTOM_DEF[1]);
COLOR_BOTTOM[2]:=iniFile.ReadFloat('COLOR','COLOR_BOTTOM_B',COLOR_BOTTOM_DEF[2]);

COLOR_LEFT[0]:=iniFile.ReadFloat('COLOR','COLOR_LEFT_R',COLOR_LEFT_DEF[0]);
COLOR_LEFT[1]:=iniFile.ReadFloat('COLOR','COLOR_LEFT_G',COLOR_LEFT_DEF[1]);
COLOR_LEFT[2]:=iniFile.ReadFloat('COLOR','COLOR_LEFT_B',COLOR_LEFT_DEF[2]);

COLOR_MIG[0]:=iniFile.ReadFloat('COLOR','COLOR_MIG_R',MIG_DEF[0]);
COLOR_MIG[1]:=iniFile.ReadFloat('COLOR','COLOR_MIG_G',MIG_DEF[1]);
COLOR_MIG[2]:=iniFile.ReadFloat('COLOR','COLOR_MIG_B',MIG_DEF[2]);

COLOR_BLACK[0]:=iniFile.ReadFloat('COLOR','COLOR_BLACK_R',COLOR_BLACK_DEF[0]);
COLOR_BLACK[1]:=iniFile.ReadFloat('COLOR','COLOR_BLACK_G',COLOR_BLACK_DEF[1]);
COLOR_BLACK[2]:=iniFile.ReadFloat('COLOR','COLOR_BLACK_B',COLOR_BLACK_DEF[2]);

FON[0]:=iniFile.ReadFloat('COLOR','FON_R',FON_DEF[0]);
FON[1]:=iniFile.ReadFloat('COLOR','FON_G',FON_DEF[1]);
FON[2]:=iniFile.ReadFloat('COLOR','FON_B',FON_DEF[2]);

COL_WIDTH1:=iniFile.ReadFloat('ADD','COL_WIDTH1',COL_WIDTH1_DEF);
COL_WIDTH2:=iniFile.ReadFloat('ADD','COL_WIDTH2',COL_WIDTH2_DEF);
COL_TOP:=iniFile.ReadFloat('ADD','COL_TOP',COL_TOP_DEF);
tik:=iniFile.ReadINTEGER('ADD','tik',tik_DEF);
tik2:=iniFile.ReadINTEGER('ADD','tik2',tik2_DEF);
GS:=iniFile.ReadINTEGER('ADD','GS',GS_DEF);
SOUND:=iniFile.ReadBool('ADD','SOUND',true);
IniFile.Free;
end;

//��������� ��������� �������������
procedure INIT;
begin
//������ ����� �� ��� �����
READOPTIONS;
//���� ID ����
glNewList (ID_CUBE, GL_COMPILE);
  MAKE_ID_CUBE;
glEndList;
//��������
MAKE_NAKL;
//׸���� �����
glNewList (CUBE, GL_COMPILE);
  BLACK_CUBE;
glEndList;

KUBIK_DEFAULT;
//������� ������������������ ��������
SetLength(rotates_mas,1);
rotates_mas[0]:=0;
nnext:=false;
bback:=False;

end;
//�������� ������� ������ (������ ��� ������� �� 27 ��������� ������)
procedure BLACK_CUBE;
begin

glScalef(ZOOM,ZOOM,ZOOM);
  glBegin (GL_QUADS);
  glNormal3f(0,0,1);
    glVertex3f (-1, -1, 1);
    glVertex3f (1, -1, 1);
    glVertex3f (1, 1, 1);
    glVertex3f (-1, 1, 1);
  glEnd;
 glBegin (GL_QUADS);
  glNormal3f(0,0,-1);
    glVertex3f (-1, -1, -1);
    glVertex3f (1, -1, -1);
    glVertex3f (1, 1, -1);
    glVertex3f (-1, 1, -1);
  glEnd;
  glBegin (GL_QUADS);
    glNormal3f(-1,0,0);
    glVertex3f (-1, -1, -1);
    glVertex3f (-1, 1, -1);
    glVertex3f (-1, 1, 1);
    glVertex3f (-1, -1,1);
  glEnd;
  glBegin (GL_QUADS);
    glNormal3f(1,0,0);
    glVertex3f (1, -1, -1);
    glVertex3f (1, 1, -1);
    glVertex3f (1, 1, 1);
    glVertex3f (1, -1,1);
  glEnd;
  glBegin (GL_QUADS);
    glNormal3f(0,1,0);
    glVertex3f (-1, 1, -1);
    glVertex3f (1, 1, -1);
    glVertex3f (1, 1, 1);
    glVertex3f (-1, 1,1);
  glEnd;
   glBegin (GL_QUADS);
    glNormal3f(0,-1,0);
    glVertex3f (-1, -1, -1);
    glVertex3f (1, -1, -1);
    glVertex3f (1, -1, 1);
    glVertex3f (-1, -1,1);
  glEnd;
 glScalef(1/ZOOM,1/ZOOM,1/ZOOM);
end;
//�������� ������� ��������(�� �������� ������)
Procedure MAKE_NAKL;
   //�������� ������ ������� ��������
    procedure COLOR_NAKL;
    var a,b,c:GLfloat;
        //���������� ������� � ������� ����� ������� ��������
        procedure norm(x1,y1,z1,x2,y2,z2,x3,y3,z3:GLfloat);
        var SQR:GLfloat;
          begin
            A := y1 *(z2 - z3) + y2* (z3 - z1) + y3* (z1 - z2);
            B := z1* (x2 - x3) + z2* (x3 - x1) + z3 *(x1 - x2);
            C := x1 *(y2 - y3) + x2 *(y3 - y1) + x3 *(y1 - y2);
            SQR:=Sqrt(a*a+b*b+c*c);
            A:=(a/SQR);
            B:=(b/SQR);
            C:=(c/SQR);
          end;
        //�������� ������� ����� ������� ��������
        procedure GRAN;
          begin
            glBegin (GL_QUADS);
            glNormal3f(A,B,C);
            glVertex3f (1, COL_WIDTH2,COL_WIDTH2);
            glVertex3f (COL_TOP, COL_WIDTH1,COL_WIDTH1);
            glVertex3f (COL_TOP, COL_WIDTH1,-COL_WIDTH1);
            glVertex3f (1, COL_WIDTH2,-COL_WIDTH2);
            glEnd;
          end;
    begin
    //��������������� ������� ��������
    glScalef(ZOOM,ZOOM,ZOOM);
    //�������
    glBegin (GL_QUADS);
      glNormal3f(1,0,0);
      glVertex3f (COL_TOP, -COL_WIDTH1, -COL_WIDTH1);
      glVertex3f (COL_TOP, COL_WIDTH1, -COL_WIDTH1);
      glVertex3f (COL_TOP, COL_WIDTH1, COL_WIDTH1);
      glVertex3f (COL_TOP, -COL_WIDTH1,COL_WIDTH1);
    glEnd;
    //�������  � ������� ����� ������� ��������
    norm(1, COL_WIDTH2,COL_WIDTH2,COL_TOP, COL_WIDTH1,COL_WIDTH1,COL_TOP, COL_WIDTH1,-COL_WIDTH1);
    //4 ����� ������� �������� (������� � �������)
    GRAN;
    glRotatef(90,-1,0,0);
    GRAN;
    glRotatef(90,-1,0,0);
    GRAN;
    glRotatef(90,-1,0,0);
    GRAN;
    //������� � ��������� ��������
    glScalef(1/ZOOM,1/ZOOM,1/ZOOM);
    end;
 begin
//6 ��������(������ ������, ���������������� ������)
 glNewList (NAKL_FRONT, GL_COMPILE);
   glPushMatrix;
   glRotatef(-90,0,1,0);
   COLOR_NAKL;
   glpopmatrix;
 glEndList;

 glNewList (NAKL_BACK, GL_COMPILE);
   glPushMatrix;
   glRotatef(90,0,1,0);
   COLOR_NAKL;
   glpopmatrix;
 glEndList;

 glNewList (NAKL_TOP, GL_COMPILE);
    glPushMatrix;
    glRotatef(90,0,0,1);
    COLOR_NAKL;
    glpopmatrix;
 glEndList;

 glNewList (NAKL_BOTTOM, GL_COMPILE);
    glPushMatrix;
    glRotatef(-90,0,0,1);
    COLOR_NAKL;
    glpopmatrix;
 glEndList;

 glNewList (NAKL_RIGHT, GL_COMPILE);
    glPushMatrix;
    COLOR_NAKL;
    glpopmatrix;
 glEndList;

 glNewList (NAKL_LEFT, GL_COMPILE);
    glPushMatrix;
    glRotatef(180,0,1,0);
    COLOR_NAKL;
    glpopmatrix;
 glEndList;
end;
//�������� ID ����
procedure MAKE_ID_CUBE;
var i,j,k:integer;CUR:GLfloat;
const
 //��� �����
  STEP :GLfloat = 1/127;
begin
CUR:=1/127;
//�������� ������������� 9x6 ��������� ������ ������
for i := -1 to 1 do
      for j := -1 to 1 do
      begin
      glPushMatrix;
      glTranslatef((2*ZOOM)*i,(2*ZOOM)*j,(2*ZOOM));
       glBegin (GL_QUADS);
       glColor3f(CUR,0,0);
        glVertex3f (-ZOOM, -ZOOM, ZOOM);
        glVertex3f (ZOOM, -ZOOM, ZOOM);
        glVertex3f (ZOOM, ZOOM, ZOOM);
        glVertex3f (-ZOOM, ZOOM, ZOOM);
        glEnd;
      glPopMatrix;
      CUR:=CUR+1/127;
      end;

for i := -1 to 1 do
      for j := -1 to 1 do
      begin
      glPushMatrix;
      glTranslatef((2*ZOOM)*i,(2*ZOOM)*j,-(2*ZOOM));
      glBegin (GL_QUADS);
        glColor3f(CUR,0,0);
        glVertex3f (-ZOOM, -ZOOM, -ZOOM);
        glVertex3f (ZOOM, -ZOOM, -ZOOM);
        glVertex3f (ZOOM, ZOOM, -ZOOM);
        glVertex3f (-ZOOM, ZOOM, -ZOOM);
      glEnd;
      glPopMatrix; CUR:=CUR+1/127;
      end;

for j := -1 to 1 do
      for k := -1 to 1 do
      begin
      glPushMatrix;
      glTranslatef(-(2*ZOOM),(2*ZOOM)*j,(2*ZOOM)*k);
      glBegin (GL_QUADS);
        glColor3f(CUR,0,0);
        glVertex3f (-ZOOM, -ZOOM, -ZOOM);
        glVertex3f (-ZOOM, ZOOM, -ZOOM);
        glVertex3f (-ZOOM, ZOOM, ZOOM);
        glVertex3f (-ZOOM, -ZOOM,ZOOM);
      glEnd;
      glPopMatrix; CUR:=CUR+1/127;
      end;

for j := -1 to 1 do
      for k := -1 to 1 do
      begin
      glPushMatrix;
      glTranslatef((2*ZOOM),(2*ZOOM)*j,(2*ZOOM)*k);
      glBegin (GL_QUADS);
        glColor3f(CUR,0,0);
        glVertex3f (ZOOM, -ZOOM, -ZOOM);
        glVertex3f (ZOOM, ZOOM, -ZOOM);
        glVertex3f (ZOOM, ZOOM, ZOOM);
        glVertex3f (ZOOM, -ZOOM,ZOOM);
      glEnd;
      glPopMatrix; CUR:=CUR+1/127;
      end;
for i := -1 to 1 do
      for k := -1 to 1 do
      begin
      glPushMatrix;
      glTranslatef((2*ZOOM)*i,(2*ZOOM),(2*ZOOM)*k);
        glBegin (GL_QUADS);
          glColor3f(CUR,0,0);
          glVertex3f (-ZOOM, ZOOM, -ZOOM);
          glVertex3f (ZOOM, ZOOM, -ZOOM);
          glVertex3f (ZOOM, ZOOM, ZOOM);
          glVertex3f (-ZOOM, ZOOM,ZOOM);
        glEnd;
      glPopMatrix;CUR:=CUR+1/127;
      end;
for i := -1 to 1 do
      for k := -1 to 1 do
        begin
          glPushMatrix;
            glTranslatef((2*ZOOM)*i,-(2*ZOOM),(2*ZOOM)*k);
            glBegin (GL_QUADS);
              glColor3f(CUR,0,0);
              glVertex3f (-ZOOM, -ZOOM, -ZOOM);
              glVertex3f (ZOOM, -ZOOM, -ZOOM);
              glVertex3f (ZOOM, -ZOOM, ZOOM);
              glVertex3f (-ZOOM, -ZOOM,ZOOM);
            glEnd;
          glPopMatrix;CUR:=CUR+1/127;
        end;
end;
//�������������� ������ ������ 27 ��������� ������
procedure KUBIK_DEFAULT;
var i,j,k:ShortInt;
begin
NO_MIG;
for i:=-1 to 1 do
  for j:=-1 to 1 do
     for k:=-1 to 1 do
       begin
        KUBIK[i,j,k].FRONT:=nil;
        KUBIK[i,j,k].BACK:=nil;
        KUBIK[i,j,k].LEFT:=nil;
        KUBIK[i,j,k].RIGHT:=nil;
        KUBIK[i,j,k].TOP:=nil;
        KUBIK[i,j,k].BOTTOM:=nil;
        KUBIK[i,j,k].elem:=(1-k)*9+3*(1+j)+2+i;
      //  KUBIK[i,j,k].edit:=false;
       end;
   for i:=-1 to 1 do
      for j:=-1 to 1 do
       begin
         KUBIK[i,j,1].FRONT:=@COLOR_FRONT;
         KUBIK[i,j,-1].BACK:=@COLOR_BACK;
         KUBIK[i,1,j].TOP:=@COLOR_TOP;
         KUBIK[i,-1,j].BOTTOM:=@COLOR_BOTTOM;
         KUBIK[1,i,j].RIGHT:=@COLOR_RIGHT;
         KUBIK[-1,i,j].LEFT:=@COLOR_LEFT;
       end;
end;


end.
