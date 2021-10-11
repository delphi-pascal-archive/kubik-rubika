unit SELECT_UNIT;
interface
uses  Windows,OpenGL,FRMMAIN_UNIT, INIT_UNIT;
//Определение вращения при клике по элементам
procedure SELECT_CUBE(EL1,EL2:byte);
function EL_FROM_COL(i,j,k:ShortInt):byte;
procedure NO_MIG;
implementation
//Отключение мигания всех цветовых элементов
procedure NO_MIG;
var i,j,k:ShortInt;
begin
  for i:=-1 to 1 do
    for j:=-1  to 1 do
      for k:=-1  to 1 do
         begin
           KUBIK[i,j,k].FRONT_ACTIVE:=False;
           KUBIK[i,j,k].BACK_ACTIVE:=False;
           KUBIK[i,j,k].LEFT_ACTIVE:=False;
           KUBIK[i,j,k].RIGHT_ACTIVE:=False;
           KUBIK[i,j,k].TOP_ACTIVE:=False;
           KUBIK[i,j,k].BOTTOM_ACTIVE:=False;
         end;
end;
//Функция сопоставления элементов и цветов
function EL_FROM_COL(i,j,k:ShortInt):byte;
var sumel:integer;  tmp:boolean;
//каждому цвету сопоставляем число
const top=1;bottom=10;front=100;back=1000;left=10000;right=100000;
begin
//Вычисляем сумму для конкретного элемента
sumel:=0;
if (kubik[i,j,k].TOP<>nil) then
  begin
    if (kubik[i,j,k].TOP=@color_top)then sumel:=top else
    if (kubik[i,j,k].TOP=@color_bottom)then sumel:=sumel+bottom else
    if (kubik[i,j,k].TOP=@color_left)then sumel:=sumel+left else
    if (kubik[i,j,k].TOP=@color_right)then sumel:=sumel+right else
    if (kubik[i,j,k].TOP=@color_front)then sumel:=sumel+front else
    if (kubik[i,j,k].TOP=@color_back)then sumel:=sumel+back;
  end;

if (kubik[i,j,k].BOTTOM<>nil) then
  begin
    if(kubik[i,j,k].BOTTOM=@color_top)then sumel:=sumel+top else
    if(kubik[i,j,k].BOTTOM=@color_bottom)then sumel:=sumel+bottom else
    if(kubik[i,j,k].BOTTOM=@color_left)then sumel:=sumel+left else
    if(kubik[i,j,k].BOTTOM=@color_right)then sumel:=sumel+right else
    if(kubik[i,j,k].BOTTOM=@color_front)then sumel:=sumel+front else
    if(kubik[i,j,k].BOTTOM=@color_back)then sumel:=sumel+back;
  end;

if (kubik[i,j,k].RIGHT<>nil) then
  begin
    if(kubik[i,j,k].RIGHT=@color_top)then sumel:=sumel+top else
    if(kubik[i,j,k].RIGHT=@color_bottom)then sumel:=sumel+bottom else
    if(kubik[i,j,k].RIGHT=@color_left)then sumel:=sumel+left else
    if(kubik[i,j,k].RIGHT=@color_right)then sumel:=sumel+right else
    if(kubik[i,j,k].RIGHT=@color_front)then sumel:=sumel+front else
    if(kubik[i,j,k].RIGHT=@color_back)then sumel:=sumel+back;
  end;
if (kubik[i,j,k].FRONT<>nil) then
  begin
    if(kubik[i,j,k].FRONT=@color_top)then sumel:=sumel+top else
    if(kubik[i,j,k].FRONT=@color_bottom)then sumel:=sumel+bottom else
    if(kubik[i,j,k].FRONT=@color_left)then sumel:=sumel+left else
    if(kubik[i,j,k].FRONT=@color_right)then sumel:=sumel+right else
    if(kubik[i,j,k].FRONT=@color_back)then sumel:=sumel+back else
    if(kubik[i,j,k].FRONT=@color_front)then sumel:=sumel+front;
  end;

if (kubik[i,j,k].BACK<>nil) then
  begin
    if(kubik[i,j,k].BACK=@color_top)then sumel:=sumel+top else
    if(kubik[i,j,k].BACK=@color_bottom)then sumel:=sumel+bottom else
    if(kubik[i,j,k].BACK=@color_left)then sumel:=sumel+left else
    if(kubik[i,j,k].BACK=@color_right)then sumel:=sumel+right else
    if(kubik[i,j,k].BACK=@color_front)then sumel:=sumel+front else
    if(kubik[i,j,k].BACK=@color_back)then sumel:=sumel+back;
  end;
if (kubik[i,j,k].LEFT<>nil) then
  begin
    if(kubik[i,j,k].LEFT=@color_top)then sumel:=sumel+top else
    if(kubik[i,j,k].LEFT=@color_bottom)then sumel:=sumel+bottom else
    if(kubik[i,j,k].LEFT=@color_left)then sumel:=sumel+left else
    if(kubik[i,j,k].LEFT=@color_right)then sumel:=sumel+right else
    if(kubik[i,j,k].LEFT=@color_front)then sumel:=sumel+front else
    if(kubik[i,j,k].LEFT=@color_back)then sumel:=sumel+back;
  end;

//Флаг некорректно введённого элемента
tmp:=false;
//определяем элемент по сумме
case sumel of  //
  left+front+bottom:Result:=1;
  //Не угловой элемент (на случай если в угловых введены не все цвета)
  front+bottom:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=2 else tmp:=true;
  right+front+bottom:Result:=3;
  left+front:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=4 else tmp:=true;
  //Не двухцветный элемент
  front:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=5 else tmp:=true;
  right+front:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=6 else tmp:=true;
  left+front+top:Result:=7;
  front+top:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=8 else tmp:=true;
  right+front+top:Result:=9;
  left+bottom:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=10 else tmp:=true;
  bottom:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=11 else tmp:=true;
  right+bottom:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=12 else tmp:=true;
  left:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=13 else tmp:=true;
  right:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=15 else tmp:=true;
  left+top:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=16 else tmp:=true;
  top:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=17 else tmp:=true;
  right+top:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=18 else tmp:=true;
  left+back+bottom:Result:=19;
  back+bottom:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=20 else tmp:=true;
  right+back+bottom:Result:=21;
  left+back:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=22 else tmp:=true;
  back:if ((1-k)*9+3*(1+j)+2+i in [5,11,13,15,17,23])  then Result:=23 else tmp:=true;
  right+back:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=24 else tmp:=true;
  left+back+top:Result:=25;
  back+top:if not((1-k)*9+3*(1+j)+2+i in [1,3,7,9,19,21,25,27])  then Result:=26 else tmp:=true;
  right+back+top:Result:=27;
  else tmp:=true;
end;
if tmp then
        begin
          Result:=0;
        end;
end;
procedure SELECT_CUBE(EL1,EL2:byte);
begin
if edit_mode   then
  begin
    if  (el1 = el2)and (el1<>5)and (el1<>41)and (el1<>50)and (el1<>32)and (el1<>23)and (el1<>14) then
      case el1 of
      1:begin   NO_MIG;edit_el:=@kubik[-1,-1,1].front;kubik[-1,-1,1].FRONT_ACTIVE:=true;end;
      2:begin   NO_MIG;edit_el:=@kubik[-1,0,1].front;kubik[-1,0,1].FRONT_ACTIVE:=true; end;
      3:begin   NO_MIG;edit_el:=@kubik[-1,1,1].front; kubik[-1,1,1].FRONT_ACTIVE:=true;end;
      4:begin   NO_MIG;edit_el:=@kubik[0,-1,1].front;kubik[0,-1,1].FRONT_ACTIVE:=true; end;
      5:edit_el:=@kubik[0,0,1].front;
      6:begin   NO_MIG;edit_el:=@kubik[0,1,1].front;  kubik[0,1,1].FRONT_ACTIVE:=true; end;
      7:begin   NO_MIG;edit_el:=@kubik[1,-1,1].front; kubik[1,-1,1].FRONT_ACTIVE:=true;end;
      8:begin   NO_MIG;edit_el:=@kubik[1,0,1].front;  kubik[1,0,1].FRONT_ACTIVE:=true; end;
      9:begin   NO_MIG;edit_el:=@kubik[1,1,1].front;  kubik[1,1,1].FRONT_ACTIVE:=true; end;

      10:begin   NO_MIG;edit_el:=@kubik[-1,-1,-1].back; kubik[-1,-1,-1].BACK_ACTIVE:=true; end;
      11:begin   NO_MIG;edit_el:=@kubik[-1,0,-1].back; kubik[-1,0,-1].BACK_ACTIVE:=true; end;
      12:begin   NO_MIG;edit_el:=@kubik[-1,1,-1].back; kubik[-1,1,-1].BACK_ACTIVE:=true; end;
      13:begin   NO_MIG;edit_el:=@kubik[0,-1,-1].back; kubik[0,-1,-1].BACK_ACTIVE:=true; end;
      14:edit_el:=@kubik[0,0,-1].back;
      15:begin   NO_MIG;edit_el:=@kubik[0,1,-1].back;  kubik[0,1,-1].BACK_ACTIVE:=true; end;
      16:begin   NO_MIG;edit_el:=@kubik[1,-1,-1].back; kubik[1,-1,-1].BACK_ACTIVE:=true; end;
      17:begin   NO_MIG;edit_el:=@kubik[1,0,-1].back; kubik[1,0,-1].BACK_ACTIVE:=true; end;
      18:begin   NO_MIG;edit_el:=@kubik[1,1,-1].back; kubik[1,1,-1].BACK_ACTIVE:=true; end;

      19:begin   NO_MIG;edit_el:=@kubik[-1,-1,-1].left; kubik[-1,-1,-1].left_ACTIVE:=true; end;
      20:begin   NO_MIG;edit_el:=@kubik[-1,-1,0].left;  kubik[-1,-1,0].left_ACTIVE:=true; end;
      21:begin   NO_MIG;edit_el:=@kubik[-1,-1,1].left;   kubik[-1,-1,1].left_ACTIVE:=true; end;
      22:begin   NO_MIG;edit_el:=@kubik[-1,0,-1].left;   kubik[-1,0,-1].left_ACTIVE:=true; end;
      23:edit_el:=@kubik[-1,0,0].left;
      24:begin   NO_MIG;edit_el:=@kubik[-1,0,1].left;    kubik[-1,0,1].left_ACTIVE:=true; end;
      25:begin   NO_MIG;edit_el:=@kubik[-1,1,-1].left;  kubik[-1,1,-1].left_ACTIVE:=true; end;
      26:begin   NO_MIG;edit_el:=@kubik[-1,1,0].left;   kubik[-1,1,0].left_ACTIVE:=true; end;
      27:begin   NO_MIG;edit_el:=@kubik[-1,1,1].left;   kubik[-1,1,1].left_ACTIVE:=true; end;

      28:begin   NO_MIG;edit_el:=@kubik[1,-1,-1].right;   kubik[1,-1,-1].right_ACTIVE:=true; end;
      29:begin   NO_MIG;edit_el:=@kubik[1,-1,0].right;   kubik[1,-1,0].right_ACTIVE:=true; end;
      30:begin   NO_MIG;edit_el:=@kubik[1,-1,1].right;   kubik[1,-1,1].right_ACTIVE:=true; end;
      31:begin   NO_MIG;edit_el:=@kubik[1,0,-1].right;   kubik[1,0,-1].right_ACTIVE:=true; end;
      32: edit_el:=@kubik[1,0,0].right;
      33:begin   NO_MIG;edit_el:=@kubik[1,0,1].right;    kubik[1,0,1].right_ACTIVE:=true; end;
      34:begin   NO_MIG;edit_el:=@kubik[1,1,-1].right;    kubik[1,1,-1].right_ACTIVE:=true; end;
      35:begin   NO_MIG;edit_el:=@kubik[1,1,0].right;     kubik[1,1,0].right_ACTIVE:=true; end;
      36:begin   NO_MIG;edit_el:=@kubik[1,1,1].right;     kubik[1,1,1].right_ACTIVE:=true; end;

      37:begin   NO_MIG;edit_el:=@kubik[-1,1,-1].TOP;    kubik[-1,1,-1].TOP_ACTIVE:=true; end;
      38:begin   NO_MIG;edit_el:=@kubik[-1,1,0].TOP;     kubik[-1,1,0].TOP_ACTIVE:=true; end;
      39:begin   NO_MIG;edit_el:=@kubik[-1,1,1].TOP;    kubik[-1,1,1].TOP_ACTIVE:=true; end;
      40:begin   NO_MIG;edit_el:=@kubik[0,1,-1].TOP;    kubik[0,1,-1].TOP_ACTIVE:=true; end;
      41:edit_el:=@kubik[0,1,0].TOP;
      42:begin   NO_MIG;edit_el:=@kubik[0,1,1].TOP;     kubik[0,1,1].TOP_ACTIVE:=true; end;
      43:begin   NO_MIG;edit_el:=@kubik[1,1,-1].TOP;    kubik[1,1,-1].TOP_ACTIVE:=true; end;
      44:begin   NO_MIG;edit_el:=@kubik[1,1,0].TOP;     kubik[1,1,0].TOP_ACTIVE:=true; end;
      45:begin   NO_MIG;edit_el:=@kubik[1,1,1].TOP;      kubik[1,1,1].TOP_ACTIVE:=true; end;

      46:begin   NO_MIG;edit_el:=@kubik[-1,-1,-1].Bottom;  kubik[-1,-1,-1].Bottom_ACTIVE:=true; end;
      47:begin   NO_MIG;edit_el:=@kubik[-1,-1,0].Bottom;   kubik[-1,-1,0].Bottom_ACTIVE:=true; end;
      48:begin   NO_MIG;edit_el:=@kubik[-1,-1,1].Bottom;   kubik[-1,-1,1].Bottom_ACTIVE:=true; end;
      49:begin   NO_MIG;edit_el:=@kubik[0,-1,-1].Bottom;  kubik[0,-1,-1].Bottom_ACTIVE:=true; end;
      50:edit_el:=@kubik[0,-1,0].Bottom;
      51:begin   NO_MIG;edit_el:=@kubik[0,-1,1].Bottom;    kubik[0,-1,1].Bottom_ACTIVE:=true; end;
      52:begin   NO_MIG;edit_el:=@kubik[1,-1,-1].Bottom;   kubik[1,-1,-1].Bottom_ACTIVE:=true; end;
      53:begin   NO_MIG;edit_el:=@kubik[1,-1,0].Bottom;    kubik[1,-1,0].Bottom_ACTIVE:=true; end;
      54:begin   NO_MIG;edit_el:=@kubik[1,-1,1].Bottom;     kubik[1,-1,1].Bottom_ACTIVE:=true; end;

      end;
    if pointer(edit_el^)=nil then frmGL.RadioButton4.Checked:=true else
    if pointer(edit_el^)=@color_left then frmGL.RadioButton5.Checked:=true else
    if pointer(edit_el^)=@color_right then frmGL.RadioButton6.Checked:=true else

    if pointer(edit_el^)=@color_bottom then frmGL.RadioButton7.Checked:=true else
    if pointer(edit_el^)=@color_back then frmGL.RadioButton3.Checked:=true else

    if pointer(edit_el^)=@color_top then frmGL.RadioButton2.Checked:=true else
    if pointer(edit_el^)=@color_front then frmGL.RadioButton1.Checked:=true;
  end

//Перебираем варианты выбора элемента
else with frmGL do
    case EL1 of
      1: case EL2 of
         4,7,30,29,28: N.Click;
         19,20,21 : Ns.Click;
         2,3,37,38,39 : Ls.Click;
         46,47,48 : L.Click;
         8 : Fs.Click;
         6 : F.Click;
         end;

      2: case EL2 of
         3,39,38,37: Ls.Click;
         1,48,47,46 : L.Click;
         5,8,33,32,31 : Svs.Click;
         24,23,22 : Sv.Click;
         6,9 : F.Click;
         4,7 : Fs.Click;
         end;

      3: case EL2 of
         6,9,36,35,34: Vs.Click;
         27,26,25 : V.Click;
         39,38,37 : Ls.Click;
         2,1,48,47,46 : L.Click;
         8 : F.Click;
         4 : Fs.Click;
         end;

      4: case EL2 of
         5,6,42,41,40: Sp.Click;
         51,50,49: Sps.Click;
         1,21,20,19 : Ns.Click;
         7,30,29,28 : N.Click;
         2 : F.Click;
         8 : Fs.Click;
         end;
       5: case EL2 of
         6,42,41,40: Sp.Click;
         4,51,50,49: Sps.Click;
         2,24,23,22 : Sv.Click;
         8,33,32,31 : Svs.Click;
         end;
       6: case EL2 of
         42,41,40: Sp.Click;
         5,4,51,50,49 : Sps.Click;
         3,27,26,25 : V.Click;
         9,36,35,34: Vs.Click;
         8,7 : F.Click;
         2,1 : Fs.Click;
         end;
    7: case EL2 of
         8,9,45,44,43: P.Click;
         54,53,52 : Ps.Click;
         4,1,21,20,19 : Ns.Click;
         30,29,28 : N.Click;
         6 : Fs.Click;
         2 : F.Click;
         end;
     8: case EL2 of
         9,45,44,43: P.Click;
         7,54,53,52 : Ps.Click;
         5,2,24,23,22 : Sv.Click;
         33,32,31 : Svs.Click;
         4,1 : F.Click;
         6,3 : Fs.Click;
         end;
     9: case EL2 of
         45,44,43: P.Click;
         8,7,54,53,52: Ps.Click;
         6,3,27,26,25 : V.Click;
         36,35,34 : Vs.Click;
         4 : F.Click;
         2 : Fs.Click;
         end;
////////////////////////////////////////////////////////////////////////
      10: case EL2 of
         11,12,37,38,39: L.Click;
         46,47,48 : Ls.Click;
         13,16,28,29,30: Ns.Click;
         19,20,21: N.Click;
         15 : T.Click;
         17 : Ts.Click;
         end;

     11: case EL2 of
        12,37,38,39: L.Click;
         10,46,47,48 : Ls.Click;
        14,17,31,32,33 : Sv.Click;
        22,23,24 : Svs.Click;
         13,16 : T.Click;
         15,18 : Ts.Click;
         end;

     12: case EL2 of
         37,38,39: L.Click;
         11,10,46,47,48 : Ls.Click;
         15,18,34,35,36: V.Click;
         25,26,27 : Vs.Click;
         13 : T.Click;
         17 : Ts.Click;
         end;

      13: case EL2 of
         14,15,40,41,42: Sps.Click;
         49,50,51: Sp.Click;
         16,28,29,30 : Ns.Click;
         10,19,20,21 : N.Click;
         17,18 : T.Click;
        11,12 : Ts.Click;
         end;
       14: case EL2 of
         15,40,41,42: Sps.Click;
         13,49,50,51: Sp.Click;
         17,31,32,33 : Sv.Click;
         11,22,23,24 : Svs.Click;
         end;
      15: case EL2 of
         40,41,42: Sps.Click;
         14,13,49,50,51 : Sp.Click;
        18,34,35,36 : V.Click;
        12,25,26,27: Vs.Click;
         11,10 : T.Click;
         17,16 : Ts.Click;
         end;
    16: case EL2 of
         17,18,43,44,45: Ps.Click;
         52,53,54 : P.Click;
         28,29,30 : Ns.Click;
         13,10,19,20,21 : N.Click;
         15 : T.Click;
        11 : Ts.Click;
         end;
     17: case EL2 of
         18,43,44,45: Ps.Click;
         16,52,53,54: P.Click;
         31,32,33: Sv.Click;
         14,11,22,23,24 : Svs.Click;
         15,12 : T.Click;
         13,10 : Ts.Click;
         end;
     18: case EL2 of
         43,44,45: Ps.Click;
         17,16,52,53,54: P.Click;
         34,35,36: V.Click;
         15,12,25,26,27: Vs.Click;
         11 : T.Click;
         13 : Ts.Click;
         end;
////////////////////////////////////////////////////////////////////////
      19: case EL2 of
        22,25,37,40,43: Ts.Click;
         46,49,52 : T.Click;
         10,13,16: Ns.Click;
         20,21,1,4,7: N.Click;
         26: L.Click;
         24 : Ls.Click;
         end;

     20: case EL2 of
        23,26,38,41,44: Sf.Click;
        47,50,53: Sfs.Click;
        19,10,13,16 : Ns.Click;
        21,1,4,7: N.Click;
         22,25 : L.Click;
         24,27 : Ls.Click;
         end;

     21: case EL2 of
         24,27,39,42,45: F.Click;
         48,51,54 : Fs.Click;
         20,19,10,13,16: Ns.Click;
         1,4,7: N.Click;
         22 : L.Click;
         26 : Ls.Click;
         end;

      22: case EL2 of
         25,37,40,43: Ts.Click;
         19,46,49,52: T.Click;
         11,14,17: Sv.Click;
         23,24,2,5,8: Svs.Click;
         26,27 : L.Click;
         20,21: Ls.Click;
         end;
       23: case EL2 of
        26,38,41,44: Sf.Click;
         20,47,50,53: Sfs.Click;
         22,11,14,17 : Sv.Click;
        24,2,5,8: Svs.Click;
         end;
      24: case EL2 of
         27,39,42,45: F.Click;
         21,48,51,54 : Fs.Click;
        23,22,11,14,17: Sv.Click;
        2,5,8: Svs.Click;
         20,19 : L.Click;
         26,25 : Ls.Click;
         end;
    25: case EL2 of
        37,40,43: Ts.Click;
         22,19,46,49,52 : T.Click;
         12,15,18: V.Click;
         26,27,3,6,9 : Vs.Click;
         24 : L.Click;
         20 : Ls.Click;
         end;
    26: case EL2 of
         38,41,44: Sf.Click;
         23,20,47,50,53: Sfs.Click;
         25,12,15,18: V.Click;
         27,3,6,9: Vs.Click;
         24,21 : L.Click;
         22,19: Ls.Click;
         end;
     27: case EL2 of
         39,42,45: F.Click;
         24,21,48,51,54: Fs.Click;
         26,25,12,15,18: V.Click;
         3,6,9: Vs.Click;
         20 : L.Click;
         22 : Ls.Click;
         end;
////////////////////////////////////////////////////////////////////////
    28: case EL2 of
        31,34,43,40,37: T.Click;
         52,49,46 : Ts.Click;
         29,30,7,4,1: Ns.Click;
         16,13,10: N.Click;
         33: P.Click;
         35 : Ps.Click;
         end;

     29: case EL2 of
        32,35,44,41,38: Sfs.Click;
       53,50,47: Sf.Click;
        30,7,4,1 : Ns.Click;
        28,16,13,10: N.Click;
         33,36: P.Click;
         31,34 : Ps.Click;
         end;

     30: case EL2 of
         33,36,45,42,39: Fs.Click;
         54,51,48: F.Click;
         7,4,1: Ns.Click;
         29,28,16,13,10: N.Click;
         35 : P.Click;
         31 : Ps.Click;
         end;

      31: case EL2 of
         34,43,40,37: T.Click;
         28,52,49,46: Ts.Click;
         32,33,8,5,2: Sv.Click;
         17,14,11: Svs.Click;
         29,30: P.Click;
         35,36: Ps.Click;
         end;
     32: case EL2 of
        35,44,41,38: Sfs.Click;
         29,53,50,47: Sf.Click;
         33,8,5,2 : Sv.Click;
        31,17,14,11: Svs.Click;
         end;
      33: case EL2 of
         36,45,42,39: Fs.Click;
        30,54,51,48 : F.Click;
        8,5,2: Sv.Click;
        32,31,17,14,11: Svs.Click;
         35,34 : P.Click;
         29,28 : Ps.Click;
         end;
    34: case EL2 of
        43,40,37: T.Click;
         31,28,52,49,46 : Ts.Click;
         35,36,9,6,3: V.Click;
         18,15,12 : Vs.Click;
         29 : P.Click;
         33 : Ps.Click;
         end;
    35: case EL2 of
        44,41,38: Sfs.Click;
        32,29,53,50,47: Sf.Click;
         36,9,6,3: V.Click;
         34,18,15,12: Vs.Click;
         31,28 : P.Click;
         33,30: Ps.Click;
         end;
    36: case EL2 of
        45,42,39: Fs.Click;
         33,30,54,51,48: F.Click;
         9,6,3: V.Click;
        35,34,18,15,12: Vs.Click;
         31 : P.Click;
         29 : Ps.Click;
         end;
////////////////////////////////////////////////////////////////////////
      37: case EL2 of
         12,11,10: Ls.Click;
         38,39,3,2,1 : L.Click;
         25,22,19: T.Click;
         40,43,34,31,28: Ts.Click;
         44 : V.Click;
         42 : Vs.Click;
         end;

     38: case EL2 of
       37,12,11,10: Ls.Click;
         39,3,2,1 : L.Click;
        26,23,20 : Sfs.Click;
        41,44,35,32,29 : Sf.Click;
         40,43 : V.Click;
         42,45: Vs.Click;
         end;

     39: case EL2 of
         38,37,12,11,10: Ls.Click;
         3,2,1 : L.Click;
        27,24,21: Fs.Click;
         42,45,36,33,30 : F.Click;
         40: V.Click;
         44: Vs.Click;
         end;

      40: case EL2 of
         15,14,13: Sp.Click;
         41,42,6,5,4: Sps.Click;
        37,25,22,19 : T.Click;
         43,34,31,28: Ts.Click;
         44,45 : V.Click;
        38,39 : Vs.Click;
         end;
       41: case EL2 of
         40,15,14,13: Sp.Click;
         42,6,5,4: Sps.Click;
         38,26,23,20 : Sfs.Click;
         44,35,32,29: Sf.Click;
         end;
      42: case EL2 of
         41,40,15,14,13: Sp.Click;
        6,5,4 : Sps.Click;
       39,27,24,21 : Fs.Click;
        45,36,33,30: F.Click;
         38,37 : V.Click;
         44,43: Vs.Click;
         end;
    43: case EL2 of
         18,17,16: P.Click;
         44,45,9,8,7 : Ps.Click;
         40,37,25,22,19 : T.Click;
         34,31,28: Ts.Click;
         42: V.Click;
         38: Vs.Click;
         end;
    44: case EL2 of
        43,18,17,16: P.Click;
         45,9,8,7: Ps.Click;
        41,38,26,23,20: Sfs.Click;
       35,32,29: Sf.Click;
         42,39 : V.Click;
         40,37 : Vs.Click;
         end;
     45: case EL2 of
         44,43,18,17,16: P.Click;
         9,8,7: Ps.Click;
         42,39,27,24,21: Fs.Click;
         36,33,30: F.Click;
         38: V.Click;
         40 : Vs.Click;
         end;
////////////////////////////////////////////////////////////////////////
      46: case EL2 of
        47,48,1,2,3: Ls.Click;
         10,11,12: L.Click;
         25,22,19: Ts.Click;
         49,52,28,31,34: T.Click;
         51: N.Click;
         53 : Ns.Click;
         end;

    47: case EL2 of
       48,1,2,3: Ls.Click;
        46,10,11,12: L.Click;
       26,23,20 : Sf.Click;
        50,53,29,32,35: Sfs.Click;
         51,54 : N.Click;
         49,52 : Ns.Click;
         end;

     48: case EL2 of
         1,2,3: Ls.Click;
         47,46,10,11,12 : L.Click;
        21,24,27: F.Click;
        51,54,30,33,36: Fs.Click;
         53 : N.Click;
         49 : Ns.Click;
         end;

      49: case EL2 of
         50,51,4,5,6: Sp.Click;
         13,14,15: Sps.Click;
        46,19,22,25: Ts.Click;
         52,28,31,34: T.Click;
         47,48 : N.Click;
         53,54: Ns.Click;
         end;
       50: case EL2 of
        51,4,5,6: Sp.Click;
         49,13,14,15: Sps.Click;
         47,20,23,26 : Sf.Click;
        53,29,32,35: Sfs.Click;
         end;
      51: case EL2 of
        4,5,6: Sp.Click;
         50,49,13,14,15 : Sps.Click;
        48,21,24,27: F.Click;
        54,30,33,36: Fs.Click;
         53,52 : N.Click;
         47,46 : Ns.Click;
         end;
    52: case EL2 of
        53,54,7,8,9: P.Click;
         16,17,18 : Ps.Click;
         49,46,19,22,25: Ts.Click;
         28,31,34 : T.Click;
         47 : N.Click;
         51: Ns.Click;
         end;
    53: case EL2 of
         54,7,8,9: P.Click;
         52,16,17,18: Ps.Click;
         50,47,20,23,26: Sf.Click;
         29,32,35: Sfs.Click;
         49,46 : N.Click;
         51,48: Ns.Click;
         end;
     54: case EL2 of
        7,8,9: P.Click;
        53,52,16,17,18: Ps.Click;
         51,48,21,24,27: F.Click;
         30,33,36: Fs.Click;
         49 : N.Click;
         47 : Ns.Click;
         end;
     end;
end;
end.

