unit ROTTHREAD_UNIT;

interface

uses
  Classes,SYSUTILS,WINDOWS,MMSYSTEM;

type
  TROTTHREAD = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses FRMMAIN_UNIT, AUTOMAT_UNIT, COLOR_ROTATE_UNIT, INIT_UNIT, OPTIONS_UNIT,
  SCENE_PAINT_UNIT, SELECT_UNIT;

//Процедура обработки тика таймера конкретного вращения
procedure TimeProc (uTimerID, uMessage: UINT; dwUser, dwl, dw2: DWORD) stdcall;
begin
    Angle:= Angle + 1;
    If Angle >= 90.0 then
      begin
      ROT_FLAG:=false;
      case ROTATE_MODE of
                   1:ROT1(KUBIK); 2:ROT2(KUBIK);3:ROT3(KUBIK);4:ROT4(KUBIK);5:ROT5(KUBIK);6:ROT6(KUBIK);
                   12:ROT12(KUBIK);11:ROT11(KUBIK);10:ROT10(KUBIK);9:ROT9(KUBIK);8:ROT8(KUBIK);7:ROT7(KUBIK);
                   13:ROT13(KUBIK);14:ROT14(KUBIK);15:ROT15(KUBIK);16:ROT16(KUBIK);17:ROT17(KUBIK);18:ROT18(KUBIK);
                   19:ROT19(KUBIK);20:ROT20(KUBIK);21:ROT21(KUBIK);22:ROT22(KUBIK);23:ROT23(KUBIK);24:ROT24(KUBIK);
                   end;
        ROTATE_MODE:=0;
        Angle:=0;
        ROT_FLAG:=true;
        timeKillEvent(TimerID);
        TimerID:=0;
      end;
    InvalidateRect (frmGL.Handle, nil, False);
end;
procedure TROTTHREAD.Execute;
function int_to_rotname(i:byte):string;
var tmp:string;
begin
case i of
1:tmp:='П';
2:tmp:='П''';
3:tmp:='C''';
4: tmp:='Сп''';
5: tmp:='Л''';
6: tmp:='Л';
7: tmp:='Ф';
8: tmp:='Ф''';
9:tmp:='Сф';
10:tmp:='Сф''';
11:tmp:='Т''';
12: tmp:='Т';
13: tmp:='В';
14: tmp:='В''';
15:tmp:='Св';
16:tmp:='Св''';
17:tmp:='Н''';
18: tmp:='Н';
19:tmp:='ФФ';
20:tmp:='ФФ''';
21:tmp:='ВВ';
22:tmp:='ВВ''';
23:tmp:='ПП';
24:tmp:='ПП''';
end;
if bback then begin if tmp[length(tmp)]='''' then tmp:=copy(tmp,1,length(tmp)-1)else tmp:=tmp+''''  end;
Result:=tmp;
end;
begin
while True do
BEGIN
SLEEP(50);
WITH  frmGL DO BEGIN
//Если таймер не свободен, и был активирован поворот
if NEXT_ROTATE and (TimerId=0)  THEN
  BEGIN
    //Если шаг назад
    if bback  then
      BEGIN
           ROTATE_MODE:=rotates_mas[mas_index-1];
           dec(mas_index);
          //Рассчитываем обратное вращение
            if ROTATE_MODE mod 2 = 0  then  dec(ROTATE_MODE) else inc(ROTATE_MODE);
            if frmGL.PLAY_BN.ImageIndex=0 then begin NEXT_ROTATE:=false; bback:=false;end;
            if mas_index =0 then begin  BACK_BN.Enabled:=false;end else  begin  BACK_BN.Enabled:=true;end;
            if mas_index = Length(rotates_mas)-1 then begin NEXT_BN.Enabled:=false;end else begin NEXT_BN.Enabled:=true;end ;
      END else
   //Если шаг вперёд
   if nnext then
    BEGIN
     ROTATE_MODE:=rotates_mas[mas_index];
     inc(mas_index);
     if  frmGL.PLAY_BN.ImageIndex=0 then  begin nnext:=false ;NEXT_ROTATE:=false; end;
     if mas_index = Length(rotates_mas)-1 then
        begin
          if not AUTO_MI.Enabled then
          begin
            NEXT_BN.Enabled:=false;
            NEXT_ROTATE:=false;
            nnext:=false;
            //Изменение копки СТОП на ПУСК
            PLAY_BN.ImageIndex:=0;PLAY_BN.Caption:='Пуск'
          end else begin NEXT_BN.Enabled:=false;end;
        end;

     if mas_index =0 then begin  BACK_BN.Enabled:=false;end else  begin  BACK_BN.Enabled:=true;end;
    END else
     //просто вращение
     begin
        ROTATE_MODE:=rotates_mas[mas_index];
        inc(mas_index);
        if mas_index = Length(rotates_mas)-1 then
        begin
         NEXT_ROTATE:=false;
         NEXT_BN.Enabled:=false;
        end;
        BACK_BN.Enabled:=true;
     end;
         //Запуск вращения
   TimerID:=timeSetEvent (active_tik, 0, @TimeProc, 0, TIME_PERIODIC);
  END;
END; //WITH
END;
end;

end.
