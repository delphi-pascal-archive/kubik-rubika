//Основная форма
unit FRMMAIN_UNIT;
interface
uses
  Windows, Messages, Classes, Graphics, Forms, ExtCtrls, Menus, Controls, 
  Dialogs, OpenGL, sysutils, StdCtrls, Buttons, ImgList, IniFiles, ComCtrls, ToolWin, 
  Grids, DBGrids, ROTTHREAD_UNIT, acAlphaImageList, acPNG,sSpeedButton,
  acAlphaHints, sHintManager;
type
  TfrmGL = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    ImageList1: TImageList;
    N6: TMenuItem;
    Panel3: TPanel;
    N8: TMenuItem;
    RESET_MI: TMenuItem;
    RANDOM_MI: TMenuItem;
    Panel5: TPanel;
    rot_panel: TPanel;
    Stop_SB: TsSpeedButton;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    N12: TMenuItem;
    EDIT_CUBE_MI: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    AUTO_MI: TMenuItem;
    rrot_panel: TPanel;
    FF: TsSpeedButton;
    FFs: TsSpeedButton;
    VVs: TsSpeedButton;
    VV: TsSpeedButton;
    PP: TsSpeedButton;
    PPs: TsSpeedButton;
    F: TsSpeedButton;
    Fs: TsSpeedButton;
    L: TsSpeedButton;
    Ls: TsSpeedButton;
    N: TsSpeedButton;
    Ns: TsSpeedButton;
    P: TsSpeedButton;
    Ps: TsSpeedButton;
    Sf: TsSpeedButton;
    Sfs: TsSpeedButton;
    Sp: TsSpeedButton;
    Sps: TsSpeedButton;
    Sv: TsSpeedButton;
    Svs: TsSpeedButton;
    T: TsSpeedButton;
    Ts: TsSpeedButton;
    V: TsSpeedButton;
    Vs: TsSpeedButton;
    edit_panel: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label5: TLabel;
    Shape5: TShape;
    Shape2: TShape;
    Shape6: TShape;
    Label6: TLabel;
    Label2: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton3: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    N10: TMenuItem;
    EDITMODE_MI: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    Editmode_SB: TsSpeedButton;
    N23: TMenuItem;
    Label8: TLabel;
    RadioButton7: TRadioButton;
    Image1: TImage;
    PLAY_IL: TsAlphaImageList;
    MANUAL_MI: TMenuItem;
    NEXT_BN: TToolButton;
    BACK_BN: TToolButton;
    PLAY_BN: TToolButton;
    PLAY_TB: TToolBar;
    ROTATE_IL: TsAlphaImageList;
    ROT_IL: TsAlphaImageList;
    Image2: TImage;
                                 
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure PClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure RESET_MIClick(Sender: TObject);
    procedure RANDOM_MIClick(Sender: TObject);
    procedure Stop_SBClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure EDITMODE_MIClick(Sender: TObject);
    procedure Editmode_SBClick(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure AUTO_MIClick(Sender: TObject);
    procedure MANUAL_MIClick(Sender: TObject);
    procedure NEXT_BNClick(Sender: TObject);
    procedure BACK_BNClick(Sender: TObject);
    procedure AUTO_SGClick(Sender: TObject);
    procedure PLAY_BNClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    DC: HDC;
    hrc: HGLRC;
    down:boolean; //флаг, нажатали кнгопка мыши
    wrkx,wrky:integer;//значения координат указателя мыши панели  ВРАЩЕНИЕ
    X1,Y1:integer;//значения координат указателя мыши для ФФ ВВ ПП
    Pixel1,Pixel2 : Array [0..2] of GLByte;//Пиксель для определения объекта
    //Установка формата пикселя
    procedure SetDCPixelFormat;
    //Процедура обработки фонового режима\очереди вращений
    procedure  USER_ROTATE(Sender: TObject; var Done:boolean);
  public
  protected
  //Перерисовка окна
  procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  end;
var
  frmGL: TfrmGL;
   down:boolean; //флаг, нажатали кнопку мыши
    wrkx,wrky:integer;//значения координат указателя мыши
    //Таймер
    TimerId: uint;
    MigId: uint;
    //Поворот кубика "ВРАЩЕНИЕ"
    rot_x:integer=-15;rot_y:integer=15;
    Timer_sem:THandle;
    ROTTHREAD:TROTTHREAD;
    procedure ADD_IN_ROTMAS(mode:byte);
implementation
uses SCENE_PAINT_UNIT, INIT_UNIT,MMSystem, COLOR_ROTATE_UNIT, OPTIONS_UNIT, SELECT_UNIT, AUTOMAT_UNIT;

{$R *.DFM}

procedure ADD_IN_ROTMAS(mode:byte);
begin
  if mode=0 then
  begin
   rotates_mas[0]:=0;
   SetLength(rotates_mas,1);
   mas_index:=0;    
  end
  else
  begin
    SetLength(rotates_mas,LENGTH(rotates_mas)+1);
    rotates_mas[LENGTH(rotates_mas)-2]:=mode;
    rotates_mas[LENGTH(rotates_mas)-1]:=0;
  end;
end;

//Процедура обработки тика таймера для мигания редактируемого элемента
procedure MigProc (uTimerID, uMessage: UINT; dwUser, dwl, dw2: DWORD) stdcall;
begin
    mig:=not(mig);
    InvalidateRect (frmGL.Handle, nil, False);
end;


//Обработчик фонового режима\очереди вращений
procedure  TFRMGL.USER_ROTATE(Sender: TObject; var Done: boolean);
begin

end;
//Нажатие кнопки панели управления
procedure TfrmGL.PClick(Sender: TObject);
begin
NEXT_ROTATE:=FALSE;
active_tik:=tik;
   if  sound  then  MessageBeep(MB_ICONINFORMATION);
   //Добавление вращения в очередь, согласно нажатой кнопке
  if TSpeedButton(sender)=P then  ADD_IN_ROTMAS(1);
  if TSpeedButton(sender)=Ps then  ADD_IN_ROTMAS(2);
  if TSpeedButton(sender)=Sp then  ADD_IN_ROTMAS(3);
  if TSpeedButton(sender)=Sps then  ADD_IN_ROTMAS(4);
  if TSpeedButton(sender)=Ls then  ADD_IN_ROTMAS(5);
  if TSpeedButton(sender)=L then  ADD_IN_ROTMAS(6);

  if TSpeedButton(sender)=F then  ADD_IN_ROTMAS(7);
  if TSpeedButton(sender)=Fs then ADD_IN_ROTMAS(8);
  if TSpeedButton(sender)=Sf then  ADD_IN_ROTMAS(9);
  if TSpeedButton(sender)=Sfs then  ADD_IN_ROTMAS(10);
  if TSpeedButton(sender)=Ts then  ADD_IN_ROTMAS(11);
  if TSpeedButton(sender)=T then  ADD_IN_ROTMAS(12);

  if TSpeedButton(sender)=V then  ADD_IN_ROTMAS(13);
  if TSpeedButton(sender)=Vs then ADD_IN_ROTMAS(14);
  if TSpeedButton(sender)=Sv then  ADD_IN_ROTMAS(15);
  if TSpeedButton(sender)=Svs then ADD_IN_ROTMAS(16);
  if TSpeedButton(sender)=Ns then ADD_IN_ROTMAS(17);
  if TSpeedButton(sender)=N then  ADD_IN_ROTMAS(18);

  if TSpeedButton(sender)=FF then ADD_IN_ROTMAS(19);
  if TSpeedButton(sender)=FFs then ADD_IN_ROTMAS(20);
  if TSpeedButton(sender)=VV then  ADD_IN_ROTMAS(21);
  if TSpeedButton(sender)=VVS then  ADD_IN_ROTMAS(22);
  if TSpeedButton(sender)=PP then  ADD_IN_ROTMAS(23);
  if TSpeedButton(sender)=PPS then
    ADD_IN_ROTMAS(24);

  NEXT_ROTATE:=true;
end;
procedure TfrmGL.PLAY_BNClick(Sender: TObject);
  begin
  active_tik:=tik;
  // Если кнопка в режиме ПУСК
  if (PLAY_BN.ImageIndex=0) then
  begin
    //Если ещё остались невоспроизведённые вращения
    if mas_index <>Length(rotates_mas)-1 then
      begin
        //Флаг нажатия кнопки вперёд
        nnext:=true;
        NEXT_ROTATE:=true;
        //Изменение кнопки ПУСК на СТОП
        PLAY_BN.ImageIndex:=1;PLAY_BN.Caption:= 'Стоп';
      end;
  end  // Если кнопка в режиме СТОП
    else
    begin
    //Останавливаем вращение
      NEXT_ROTATE:=false;
      nnext:=false;
      //Изменение копки СТОП на ПУСК
      PLAY_BN.ImageIndex:=0;PLAY_BN.Caption:='Пуск'
    end;
end;

procedure TfrmGL.RadioButton1Click(Sender: TObject);
begin
if TRadioButton(Sender)=RadioButton4 then pointer(EDIT_EL^):=nil else
if TRadioButton(Sender)=RadioButton5 then pointer(EDIT_EL^):=@color_left ;
if TRadioButton(Sender)=RadioButton6 then pointer(EDIT_EL^):=@color_right else
if TRadioButton(Sender)=RadioButton7 then pointer(EDIT_EL^):=@color_bottom else
if TRadioButton(Sender)=RadioButton3 then pointer(EDIT_EL^):=@color_back else
if TRadioButton(Sender)=RadioButton2 then pointer(EDIT_EL^):=@color_top else
if TRadioButton(Sender)=RadioButton1 then pointer(EDIT_EL^):=@color_front;
if edit_mode then InvalidateRect(Handle, nil, False);
end;

procedure TfrmGL.RadioButton7Click(Sender: TObject);
begin

end;

//Перерисовка окна
procedure TfrmGL.WMPaint(var Msg: TWMPaint);
var ps : TPaintStruct;
begin
  BeginPaint(Handle, ps);
    glEnable(GL_LIGHTING);
    glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
    glLoadIdentity;
    glTranslatef (0.0, 0.0, -15.0);
    //Поворот кубика "ВРАЩЕНИЕ"
    glRotatef(ROT_X,0,1,0);
    glRotatef(ROT_Y,1,0,0);
    //Изображение кубика
    SCENE_PAINT;
    //Вывод на экран
    SwapBuffers(DC);
    //Отключение света, сброс изображения
    glDisable(GL_LIGHTING);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    //Отображение ID куба
    glCallList (ID_CUBE);  
  EndPaint(Handle, ps);
end;

//Создание окна
procedure TfrmGL.Button1Click(Sender: TObject);
begin
AUTO_ROTATING;
end;

//Включение режима редактирования
procedure TfrmGL.Editmode_SBClick(Sender: TObject);
var err:boolean;  tmp:boolean; tmp_kubik:TKubik;
procedure identelements;
var i,i1,j,j1,k,k1:shortint;
begin
//Флаг наличия ошибок ввода
err:=false;
//перебираем все элементы
for i:=-1 to 1 do
for j:=-1 to 1 do
for k:=-1 to 1 do
begin
//по цветам определяем элементы (неопределённые элементы elem = 0)
   if not((i=0)and (j=0)and (k=0)) then
     begin
        kubik[i,j,k].elem:=EL_FROM_COL(i,j,k);
        if kubik[i,j,k].elem=0 then
        begin
          err:=true;
          //Зачищаем элемент
          KUBIK[i,j,k].FRONT:=nil;KUBIK[i,j,k].BACK:=nil;KUBIK[i,j,k].LEFT:=nil;
          KUBIK[i,j,k].RIGHT:=nil;KUBIK[i,j,k].TOP:=nil;KUBIK[i,j,k].BOTTOM:=nil;
        end;
     end else kubik[i,j,k].elem:=14;
end;
//Ищем повторы элементов
for i:=-1 to 1 do
for j:=-1 to 1 do
for k:=-1 to 1 do
begin
    //Если элемент введён корректно
    if kubik[i,j,k].elem<>0 then
      begin
        tmp:=false;
        //проверяем на повторы
            for i1:=-1 to 1 do
            for j1:=-1 to 1 do
            for k1:=-1 to 1 do
                //если нашёлся совпадающий
                if (kubik[i1,j1,k1].elem=kubik[i,j,k].elem) then
                  //если это не он сам
                  if (i<>i1)or(j<>j1)or(k<>k1) then
                    begin
                     //Флаг, что нашлись совпадающие с текущим
                      tmp:=true;
                      //Флаг ошибки ввода
                      err:=true;
                      //Зачищаем элемент
                      kubik[i1,j1,k1].elem:=0;
                      kubik[i1,j1,k1].TOP:=nil; kubik[i1,j1,k1].BOTTOM:=nil;kubik[i1,j1,k1].FRONT:=nil;
                      kubik[i1,j1,k1].BACK:=nil;kubik[i1,j1,k1].LEFT:=nil;kubik[i1,j1,k1].RIGHT:=nil;
                     end;
            //Очищаем проверяемый элемент если он совпадает с каким либо
            if tmp then
                begin
                  err:=true;
                  kubik[i,j,k].elem:=0;
                  kubik[i,j,k].TOP:=nil; kubik[i,j,k].BOTTOM:=nil;kubik[i,j,k].FRONT:=nil;
                  kubik[i,j,k].BACK:=nil;kubik[i,j,k].LEFT:=nil;kubik[i,j,k].RIGHT:=nil;
                end;
    end ;
end;
 InvalidateRect(Handle, nil, False);
end;

begin
//Идентифицируем элементы\корректность ввода
identelements;
//Если нет ошибок
if not(err)then
  begin
   //Попытаемся собрать кубик
   tmp_kubik:=KUBIK;
   AUTO_ROTATING;
      if kubik_is_ok(KUBIK) then
      begin
        KUBIK:=tmp_KUBIK;
        //Разлокировка пунктра меню НАСТРОЙКА
        N6.Enabled:=True;
        //Разлокировка пунктра меню ПУСК
        N8.Enabled:=true;
        //Снимаем флаг редактирования
        edit_mode:=false;
        //Отображаем панель поворотов
        rot_panel.Visible:=true;
        //Пункт меню СМЕШАТЬ
        RANDOM_MI.Enabled:=true;
        //КНОПКА СТОП
        Stop_SB.Visible:=true;
        //Скрываем панель опреления цветов и кнопку ПРИМЕНИТЬ
        edit_panel.Visible:=false;
        Editmode_SB.Visible:=false;
        //Блокировка пунктов меню применить\отмена
        N22.Enabled:=false;
        N23.Enabled:=false;
        //откл. мигание
        NO_MIG;
      end else
      begin
        KUBIK:=tmp_KUBIK;
        Application.MessageBox('Недопустимая конфигурация кубика, проверьте корректность ввода','Внимание!',48);
      end;
  end
  else
    begin
      Application.MessageBox('Обнаружены ошибки при вводе, задайте недостающие элементы','Внимание!',48);
       InvalidateRect(Handle, nil, False);
    end;
end;

procedure TfrmGL.FormCreate(Sender: TObject);
begin

  DC := GetDC(Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  //Первичная инициализация
  INIT;
  glClearColor (FON[0],FON[1], FON[2],1);
 ROTTHREAD:=TROTTHREAD.Create(FALSE);
  Height:=Constraints.MinHeight;

  Shape1.Brush.Color:= RGB(round(COLOR_FRONT[0]*850),round(COLOR_FRONT[1]*850),round(COLOR_FRONT[2]*850));
  Shape2.Brush.Color:= RGB(round(COLOR_BACK[0]*850),round(COLOR_BACK[1]*850),round(COLOR_BACK[2]*850));
  Shape5.Brush.Color:= RGB(round(COLOR_TOP[0]*850),round(COLOR_TOP[1]*850),round(COLOR_TOP[2]*850));
  Shape6.Brush.Color:= RGB(round(COLOR_BOTTOM[0]*850),round(COLOR_BOTTOM[1]*850),round(COLOR_BOTTOM[2]*850));
  Shape4.Brush.Color:= RGB(round(COLOR_LEFT[0]*850),round(COLOR_LEFT[1]*850),round(COLOR_LEFT[2]*850));
  Shape3.Brush.Color:= RGB(round(COLOR_RIGHT[0]*850),round(COLOR_RIGHT[1]*850),round(COLOR_RIGHT[2]*850));

    //Запускаем таймер мерцания активного элемента
   MIGID:=timeSetEvent (300, 100, @MigProc, 0, TIME_PERIODIC);

  end;
//Изменение размеров окна
procedure TfrmGL.FormResize(Sender: TObject);
begin
 Panel3.Top:=ClientHeight-Panel3.Height;
 Panel3.LEFT:=ClientWIDTH-Panel5.Width-Panel3.WIDTH;
 glViewport(0, 0, ClientWidth-Panel5.Width, ClientHeight );
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 gluPerspective(20.0, (ClientWidth-Panel5.Width)/ClientHeight, 10.0,20.0);
 glMatrixMode(GL_MODELVIEW);
 InvalidateRect(Handle, nil, False);
end;
procedure TfrmGL.Image2Click(Sender: TObject);
begin

end;

//Конец работы программы
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
//Удаление созданных объектов
  glDeleteLists (28 ,8);
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC (DC);
  timeKillEvent(TimerID);
  timeKillEvent(MigID);
end;
//Обработка клика
procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
//Считываем цвет\координаты
 glReadPixels(X, ClientHeight - Y, 1, 1, GL_RGB, GL_BYTE, @Pixel1);
 X1:=X;Y1:=Y;
if edit_mode then  SELECT_CUBE(pixel1[0],pixel1[0]);
end;

//Определение поворота при клике\редактируемого элемента
procedure TfrmGL.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//Определяем цвет пикселя под курсором->Pixel2
glReadPixels(X, ClientHeight - Y, 1, 1, GL_RGB, GL_BYTE, @Pixel2);
//Если цвет красный, т.е. указали в ID куб и не включен режим редактирования
if ((pixel1[2] = 0)and(pixel1[1] = 0)and(pixel2[2] = 0)and(pixel2[1] = 0) and (pixel1[0] <55))  then
begin
        //Определение вида вращения \измененине цвета
      SELECT_CUBE(pixel1[0],pixel2[0]);//ShowMessage(inttostr(pixel1[0]));
end
else
    begin
    //Если клик вне кубика
      if (X-X1>150)and (abs(y-y1)<50) then PP.Click else
      if (X1-X>150)and (abs(y-y1)<50) then PPs.Click else

      if (Y1-Y>150)and (abs(x-x1)<50) then VV.Click else
      if (Y-Y1>150)and (abs(x-x1)<50) then VVs.Click else

      if (X-X1>100)and (Y1-Y>100) then FF.Click else
      if (X1-X>100)and (Y-Y1>100) then FFs.Click;
    end;
end;
//Устанавливаем формат пикселей
procedure TfrmGL.SetDCPixelFormat;
var
  nPixelFormat: Integer; pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);
end;


//Нажатие кнопки НАЗАД
procedure TfrmGL.BACK_BNClick(Sender: TObject);
begin
  if  sound  then  MessageBeep(MB_ICONINFORMATION);
  active_tik:=tik;
  //Ставим на СТОП в автоматическом режиме
  if PLAY_BN.ImageIndex=1 then PLAY_BN.Click;
  bback:=true;
  NEXT_ROTATE:=true;
end;
//Нажатие кнопки ВПЕРЁД
procedure TfrmGL.NEXT_BNClick(Sender: TObject);
begin
   if  sound  then  MessageBeep(MB_ICONINFORMATION);
  active_tik:=tik;
  //Ставим на СТОП в автоматическом режиме
  if PLAY_BN.ImageIndex=1 then PLAY_BN.Click;
  nnext:=true;
  NEXT_ROTATE:=true;
end;

//СТОП
procedure TfrmGL.Stop_SBClick(Sender: TObject);
begin
  NEXT_ROTATE:=false;
end;

procedure TfrmGL.AUTO_SGClick(Sender: TObject);
begin

end;

//Закрутка кубика
procedure TfrmGL.RANDOM_MIClick(Sender: TObject);
var i:byte;tmp:byte;
begin
  if  sound  then  MessageBeep(MB_ICONINFORMATION);
  NEXT_ROTATE:=false;
  mas_index:=0;
  active_tik:=tik2;
  SetLength(rotates_mas,GS+1);
  randomize;tmp:=0;
  //Заполнение очереди вращений случайными значениями
  for i:=0 to GS-1 do
    begin
      rotates_mas[i]:=Random(6)+1+tmp;
      tmp:=(tmp+6)mod 24  ;
    end;
  rotates_mas[GS]:=0;
  NEXT_ROTATE:=true;
end;

//Сохранить в файл
procedure TfrmGL.N13Click(Sender: TObject);
var  IniFile:TIniFile;i,j,k:ShortInt;
  //Запись параметров в соответствии с цветовыми значениями
  procedure writecolor(col:pointer;punkt:string);
  begin
     if col=@color_top then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'TOP')else
     if col=@color_BOTTOM then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'BOTTOM')else
     if col=@color_FRONT then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'FRONT')else
     if col=@color_BACK then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'BACK')else
     if col=@color_LEFT then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'LEFT')else
     if col=@color_RIGHT then iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'RIGHT')else
     iniFile.WriteString(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'-');
  end;
begin
if SaveDialog1.Execute then
  begin
  //Связываем переменную с файлом
  IniFile:=TIniFile.Create(SaveDialog1.FileName);
  //запись цветовых значений кубика
  for i:=-1 to 1 do
    for j:=-1  to 1 do
      for k:=-1  to 1 do
         begin
         writecolor(KUBIK[i,j,k].TOP,'COLOR_TOP');
         writecolor(KUBIK[i,j,k].BOTTOM,'COLOR_BOTTOM');
         writecolor(KUBIK[i,j,k].FRONT,'COLOR_FRONT');
         writecolor(KUBIK[i,j,k].BACK,'COLOR_BACK');
         writecolor(KUBIK[i,j,k].LEFT,'COLOR_LEFT');
         writecolor(KUBIK[i,j,k].RIGHT,'COLOR_RIGHT');
      end;
  IniFile.Free;
  end;
end;

//Открыть файл
procedure TfrmGL.N14Click(Sender: TObject);
var  IniFile:TIniFile;i,j,k:ShortInt;
  //Сопоставление параметров ini файла реальным цветовым значениям
  procedure readcolor(var el:pointer;punkt:string);
  var tmp:string;
  begin
  tmp:=iniFile.Readstring(inttostr(i)+','+inttostr(j)+','+inttostr(k),punkt,'-');
     if tmp='TOP' then el:=@color_top else
     if tmp='BOTTOM' then el:=@color_BOTTOM else
     if tmp='FRONT' then el:=@color_FRONT else
     if tmp='BACK' then el:=@color_BACK else
     if tmp='LEFT' then el:=@color_LEFT else
     if tmp='RIGHT' then el:=@color_RIGHT else el:=nil ;
  end;
begin
if OpenDialog1.Execute then
  begin
  //Связываем переменную с файлом
  IniFile:=TIniFile.Create(OpenDialog1.FileName);
  //Читаем цвета
  for i:=-1 to 1 do
    for j:=-1  to 1 do
      for k:=-1  to 1 do
         begin
           readcolor(KUBIK[i,j,k].TOP,'COLOR_TOP');
           readcolor(KUBIK[i,j,k].BOTTOM,'COLOR_BOTTOM');
           readcolor(KUBIK[i,j,k].FRONT,'COLOR_FRONT');
           readcolor(KUBIK[i,j,k].BACK,'COLOR_BACK');
           readcolor(KUBIK[i,j,k].LEFT,'COLOR_LEFT');
           readcolor(KUBIK[i,j,k].RIGHT,'COLOR_RIGHT');
         end;
  IniFile.Free;
  end;
//откл. мигание всех элементов
NO_MIG;
//Идентификация элементов
for i:=-1 to 1 do
for j:=-1 to 1 do
for k:=-1 to 1 do
  begin                 //Функция сопоставления элементов и цветов
    KUBIK[i,j,k].elem:= EL_FROM_COL(i,j,k);
    //Если есть ошибки (т.е. elem = 0 ) - влючаем режим редактирования
    if (i<>0)and (j<>0) and(k<>0) and (KUBIK[i,j,k].elem = 0 ) and not(edit_mode) then EDITMODE_MI.Click;
  end;
//Переход в ручной режим
MANUAL_MI.Click;
InvalidateRect(Handle, nil, False);
end;

//Правка кубика
procedure TfrmGL.EDITMODE_MIClick(Sender: TObject);
begin
if not(edit_mode) then EDIT_KUBIK:=kubik;
//Блокировка пунктра меню ПУСК
N8.Enabled:=false;
//Блокировка пунктра меню НАСТРОЙКА
N6.Enabled:=false;
//Разблокировка пунктов меню применить\отмена
N22.Enabled:=true;
N23.Enabled:=true;
//скрытие панели вращений
edit_mode:=true;
rot_panel.Visible:=false;
Stop_SB.Visible:=false;
//Отображение элементов управления формы
rrot_panel.Visible:=true;
edit_panel.Visible:=true;
Editmode_SB.Visible:=true;
//Остановка вращений
Stop_SB.Click;
//Делаем активным элемент(выбор+мигание)
SELECT_CUBE(3,3);
end;
//Пункт меню КУБИК-РЕДАКТИРОВАТЬ-НОВЫЙ
procedure TfrmGL.N17Click(Sender: TObject);
var i,j,k:ShortInt;
begin
if not (edit_mode) then EDIT_KUBIK:=kubik;
edit_mode:=true;
//Очищаем цвета
for i:=-1 to 1 do
  for j:=-1 to 1 do
     for k:=-1 to 1 do
       begin
       if not(((i=-1)and(j=0)and(k=0))or
       ((i=1)and(j=0)and(k=0))or
       ((i=0)and(j=1)and(k=0))or
       ((i=0)and(j=-1)and(k=0))or
       ((i=0)and(j=0)and(k=1))or
       ((i=0)and(j=0)and(k=-1))) then
         begin
          KUBIK[i,j,k].FRONT:=nil;
          KUBIK[i,j,k].BACK:=nil;
          KUBIK[i,j,k].LEFT:=nil;
          KUBIK[i,j,k].RIGHT:=nil;
          KUBIK[i,j,k].TOP:=nil;
          KUBIK[i,j,k].BOTTOM:=nil;
         end;
       end;
//Пункт меню КУБИК-РЕДАКТИРОВАТЬ-ПРАВКА
EDITMODE_MI.Click
end;

procedure TfrmGL.AUTO_MIClick(Sender: TObject);
begin
  //Расчёт поворотов автосборки
  AUTO_ROTATING;
  //Если есть повороты в автоочереди
  if auto_rotates_mas[0]<>0  then
    begin
      //Закрытие пунктов меню
      RANDOM_MI.Enabled:=false;
      MANUAL_MI.Enabled:=true;
      AUTO_MI.Enabled:=false;
      RESET_MI.Enabled:=false;
      EDIT_CUBE_MI.Enabled:=false;
      Stop_SB.Visible:=false;
      PLAY_BN.Enabled:=true;
      BACK_BN.Enabled:=false;
      NEXT_BN.Enabled:=true;
      //Закрытие кнопок
      P.Enabled:=false;
      Ps.Enabled:=false;
      Sp.Enabled:=false;
      Sps.Enabled:=false;
      Ls.Enabled:=false;
      L.Enabled:=false;

      F.Enabled:=false;
      Fs.Enabled:=false;
      Sf.Enabled:=false;
      Sfs.Enabled:=false;
      Ts.Enabled:=false;
      T.Enabled:=false;

      V.Enabled:=false;
      Vs.Enabled:=false;
      Sv.Enabled:=false;
      Svs.Enabled:=false;
      Ns.Enabled:=false;
      N.Enabled:=false;

      FF.Enabled:=false;
      FFs.Enabled:=false;
      VV.Enabled:=false;
      VVS.Enabled:=false;
      PP.Enabled:=false;
      PPS.Enabled:=false;
      //Добавление в активную очередь поворотов
      rotates_mas:=auto_rotates_mas;
      mas_index:=0;
    end
   else //иначе кубик собран
    Application.MessageBox('Кубик собран!', 'Внимание', 48)
end;

procedure TfrmGL.N23Click(Sender: TObject);
begin
KUBIK:=EDIT_KUBIK;
//Разлокировка пунктра меню НАСТРОЙКА
N6.Enabled:=True;
//Разлокировка пунктра меню ПУСК
N8.Enabled:=true;
//Снимаем флаг редактирования
edit_mode:=false;
//Отображаем панель поворотов
rot_panel.Visible:=true;
//Кнопка СТОП
Stop_SB.Visible:=true;
//Скрываем панель опреления цветов и кнопку ПРИМЕНИТЬ
edit_panel.Visible:=false;
Editmode_SB.Visible:=false;
//Блокировка пунктов меню применить\отмена
N22.Enabled:=false;
N23.Enabled:=false;
//откл. мигание
NO_MIG;
InvalidateRect(handle, nil, false);
end;
//Выбор РУЧНОГО РЕЖИМА
procedure TfrmGL.MANUAL_MIClick(Sender: TObject);
begin
  //Открытие\закрытие кнопок
  Stop_SB.Visible:=true;
  RANDOM_MI.Enabled:=true;
  AUTO_MI.Enabled:=true;
  RESET_MI.Enabled:=true;
  EDIT_CUBE_MI.Enabled:=true;
  PLAY_BN.Enabled:=false;
  BACK_BN.Enabled:=false;
  NEXT_BN.Enabled:=false;

   //Открытие кнопок
    P.Enabled:=true;
    Ps.Enabled:=true;
    Sp.Enabled:=true;
    Sps.Enabled:=true;
    Ls.Enabled:=true;
    L.Enabled:=true;

    F.Enabled:=true;
    Fs.Enabled:=true;
    Sf.Enabled:=true;
    Sfs.Enabled:=true;
    Ts.Enabled:=true;
    T.Enabled:=true;

    V.Enabled:=true;
    Vs.Enabled:=true;
    Sv.Enabled:=true;
    Svs.Enabled:=true;
    Ns.Enabled:=true;
    N.Enabled:=true;

    FF.Enabled:=true;
    FFs.Enabled:=true;
    VV.Enabled:=true;
    VVS.Enabled:=true;
    PP.Enabled:=true;
    PPS.Enabled:=true;
  //Очистка очереди вращений
  ADD_IN_ROTMAS(0);
end;

//Выход  из программы
procedure TfrmGL.N3Click(Sender: TObject);
begin
Close;
end;
//Скрытие\отображение панели управления
procedure TfrmGL.N4Click(Sender: TObject);
begin
if panel5.Width>0 then  panel5.Width:=0 else panel5.Width:=180;
  frmGL.FormResize(nil);
end;

//Вызов окна настроек
procedure TfrmGL.N6Click(Sender: TObject);
begin
//Блокировка меню редактирования
EDIT_CUBE_MI.Enabled:=false;
OPform.show;
end;

procedure TfrmGL.N8Click(Sender: TObject);
begin

end;

//Общий сброс
procedure TfrmGL.RESET_MIClick(Sender: TObject);
begin
 //Первичная ориентация
  KUBIK_DEFAULT;
  //Обнуление очереди вращений
  ADD_IN_ROTMAS(0);
  BACK_BN.Enabled:=false;NEXT_BN.Enabled:=false;
  rot_x:=-15;rot_y:=15;
  InvalidateRect(handle, nil, false);
end;


//нажатие кнопки мыши, считывание координат
procedure TfrmGL.Panel3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    wrkX := x;
    wrkY := y;
    Down := True;
end;
//При нажатой кнопке - изменение градуса вращения объектов
procedure TfrmGL.Panel3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  If Down then
    begin
    //ограничение на вращение в +-40 градусов
      if abs((rot_x+(x - wrkX))) <40 then rot_x:=(rot_x+(x - wrkX));
      if abs((rot_y+(y - wrkY))) <40 then rot_y:=(rot_y+(y - wrkY));
      InvalidateRect(handle, nil, false);
      wrkX := x;
      wrkY := y;
    end;
end;
//Отпускаем кнопку мыши
procedure TfrmGL.Panel3MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
//флаг нажатия кнопки
down:=false;
end;

end.


