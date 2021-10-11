unit AUTOMAT_UNIT;
interface
uses  Windows,FRMMAIN_UNIT,OpenGL,INIT_UNIT, COLOR_ROTATE_UNIT;
Procedure AUTO_ROTATING;
Function kubik_is_ok(kubik:tkubik):boolean;
implementation
//��������� �������� ������ ������
Function kubik_is_ok(kubik:tkubik):boolean;
var i,j:ShortInt;
begin
   for i:=-1 to 1 do
      for j:=-1 to 1 do
       begin
         if (KUBIK[i,j,1].FRONT<>@COLOR_FRONT)or(KUBIK[i,j,-1].BACK<>@COLOR_BACK)or
          (KUBIK[i,1,j].TOP<>@COLOR_TOP)or(KUBIK[i,-1,j].BOTTOM<>@COLOR_BOTTOM)or
         (KUBIK[1,i,j].RIGHT<>@COLOR_RIGHT)or(KUBIK[-1,i,j].LEFT<>@COLOR_LEFT) then
         begin
         Result:=false;
         exit;
         end;
       end;
       result:=true;
end;
Procedure AUTO_ROTATING;
var auto_kubik:TKubik;
povtor,j:byte;i,k:integer;
//���������� �������� � ������� �������� ����������
procedure ADD_IN_AUTO_ROTMAS(mode:byte);
begin
  if mode=0 then
  begin
   SetLength(auto_rotates_mas,1);
   auto_rotates_mas[0]:=0;
  end
  else
  begin
    SetLength(auto_rotates_mas,length(auto_rotates_mas)+1);
    auto_rotates_mas[length(auto_rotates_mas)-2]:=mode;
    auto_rotates_mas[length(auto_rotates_mas)-1]:=0;
  end;
end;
//���������� �������� � ������� �������� ���������� � ���� ��������
procedure ADD_IN_ROTMAS2(mode:byte);
begin
if not edit_mode then ADD_IN_AUTO_ROTMAS(mode);
  case mode of
   1:ROT1(AUTO_KUBIK); 2:ROT2(AUTO_KUBIK);3:ROT3(AUTO_KUBIK);4:ROT4(AUTO_KUBIK);5:ROT5(AUTO_KUBIK);6:ROT6(AUTO_KUBIK);
   12:ROT12(AUTO_KUBIK);11:ROT11(AUTO_KUBIK);10:ROT10(AUTO_KUBIK);9:ROT9(AUTO_KUBIK);8:ROT8(AUTO_KUBIK);7:ROT7(AUTO_KUBIK);
   13:ROT13(AUTO_KUBIK);14:ROT14(AUTO_KUBIK);15:ROT15(AUTO_KUBIK);16:ROT16(AUTO_KUBIK);17:ROT17(AUTO_KUBIK);18:ROT18(AUTO_KUBIK);
   19:ROT19(AUTO_KUBIK);20:ROT20(AUTO_KUBIK);21:ROT21(AUTO_KUBIK);22:ROT22(AUTO_KUBIK);23:ROT23(AUTO_KUBIK);24:ROT24(AUTO_KUBIK);
   end;
end;
//1 ����
procedure P1(el:Byte;colfr:Pointer);
begin
with frmGL do
  //���� � ������� �����
 if auto_kubik[0,1,1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[0,1,1].top=colfr then
          begin
            ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
          end;
        end
else
  if auto_kubik[-1,1,0].ELEM=el then
          begin
          if auto_kubik[-1,1,0].top=colfr then
            begin
              ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(3);
            end
          else
            begin //���� ������ �����������, �� ����� ������� ������� �����
              if el=8 then  ADD_IN_ROTMAS2(14) else
                begin
                  ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
                end;
            end
          end
else
  if auto_kubik[1,1,0].ELEM=el then
          begin
          if auto_kubik[1,1,0].top=colfr then
            begin
              ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
            end
          else
            if el=8 then ADD_IN_ROTMAS2(13)else
                begin
                  ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
                end;
          end
else
  if auto_kubik[0,1,-1].ELEM=el then
          begin
           if auto_kubik[0,1,-1].top=colfr then
            begin
              ADD_IN_ROTMAS2(11);ADD_IN_ROTMAS2(11);ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
            end
          else
            if el=8 then begin ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13);end else
                begin
                  ADD_IN_ROTMAS2(11);ADD_IN_ROTMAS2(11);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
                end;
          end
else
//���� � ��������
  if auto_kubik[1,0,1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[1,0,1].right=colfr then
          begin
            ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
          end
          else  ADD_IN_ROTMAS2(8);
        end
else
  if auto_kubik[-1,0,1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[-1,0,1].LEFT=colfr then
          begin
            ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(3);
          end
          else  ADD_IN_ROTMAS2(7);
        end
else
  if auto_kubik[-1,0,-1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[-1,0,-1].LEFT=colfr then
          begin
            ADD_IN_ROTMAS2(5);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
          end
          else  begin ADD_IN_ROTMAS2(5);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(3);end
        end
else
  if auto_kubik[1,0,-1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[1,0,-1].RIGHT=colfr then
          begin
            ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
          end
          else  begin ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(3);end
        end
//���� � ������ �����
else
 if auto_kubik[0,-1,1].ELEM=el then
        begin
        //� ����������� �� ���������� ��������, ���������� �������� ���������
        if auto_kubik[0,-1,1].bottom=colfr then
          begin
            ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
          end
          else
           begin
            ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
           end
        end
else
  if auto_kubik[-1,-1,0].ELEM=el then
          begin
          if auto_kubik[-1,-1,0].BOTTOM=colfr then
            begin
              ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(3);
            end
          else
            begin
              ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
            end
          end
else
  if auto_kubik[1,-1,0].ELEM=el then
          begin
          if auto_kubik[1,-1,0].BOTTOM=colfr then
            begin
              ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
            end
          else
            begin
              ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
            end;
          end
else
  if auto_kubik[0,-1,-1].ELEM=el then
          begin
           if auto_kubik[0,-1,-1].BOTTOM=colfr then
            begin
              ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(3);
            end
          else
            begin
              ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(8);
            end;
          end;
end ;
//2 ����
procedure P2(el:Byte;colfr,coltp:Pointer);
begin
//��������� ������� ������� � ������� 1 -1 1
//���� � ������� �����
 if auto_kubik[1,1,1].ELEM=el then
          begin
            if not((auto_kubik[1,1,1].top=coltp )and (auto_kubik[1,1,1].front=colfr)) then
            begin ADD_IN_ROTMAS2(2); ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(18);end;
          end
 else
 if auto_kubik[-1,1,1].ELEM=el then
            begin ADD_IN_ROTMAS2(6); ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(5);end
else
 if auto_kubik[-1,1,-1].ELEM=el then
            begin ADD_IN_ROTMAS2(5); ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(6);end
else
 if auto_kubik[1,1,-1].ELEM=el then
            begin ADD_IN_ROTMAS2(1); ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(18);end
 //����� � ������ �����
 else
 if auto_kubik[-1,-1,1].ELEM=el then
            begin ADD_IN_ROTMAS2(18);end
 else
 if auto_kubik[-1,-1,-1].ELEM=el then
            begin ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(18);end
else
 if auto_kubik[1,-1,-1].ELEM=el then
            begin ADD_IN_ROTMAS2(17);end;
 //��������� ��������
if auto_kubik[1,-1,1].elem=el then
//�������� 1
if (auto_kubik[1,-1,1].RIGHT=coltp)and (auto_kubik[1,-1,1].front=colfr)  then
        begin
         ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(1);
        end
//�������� 2
else
if (auto_kubik[1,-1,1].bottom=colfr)and (auto_kubik[1,-1,1].front=coltp)  then
        begin
         ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(8);
        end
else
//�������� 3
if (auto_kubik[1,-1,1].right=colfr)and (auto_kubik[1,-1,1].bottom=coltp)  then
        begin
         ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(17);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(18);
         //����� �������� � ����������
         P2(el,colfr,coltp);
        end;
end;
//3 ����
procedure P3(el:Byte;colfr:Pointer);
procedure var1;
begin
//(�'-�'-�-�)-(�-�-H'-�')
 ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(18); ADD_IN_ROTMAS2(1);
 ADD_IN_ROTMAS2(18); ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(8);
end;
procedure var2;
begin
//(�-�-�'-�')-(�'-�'-�-�)
 ADD_IN_ROTMAS2(18); ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(5);
 ADD_IN_ROTMAS2(17); ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(18); ADD_IN_ROTMAS2(7);
end;
begin

//���� � �������� (���������� �������� ������ var1 ��� var2)
if auto_kubik[-1,0,1].elem=el then
        begin
          var2;P3(el,colfr);
        end
else
if auto_kubik[1,0,1].elem=el then
        begin
         if auto_kubik[1,0,1].FRONT<>colfr then begin var1;P3(el,colfr); end
                else ADD_IN_ROTMAS2(24);
        end
else
if auto_kubik[1,0,-1].elem=el then
        begin
          ADD_IN_ROTMAS2(24);
          var1;
          ADD_IN_ROTMAS2(23);
          P3(el,colfr);
        end
else
if auto_kubik[-1,0,-1].elem=el then
        begin
          ADD_IN_ROTMAS2(23);
          var2;
          ADD_IN_ROTMAS2(24);
          P3(el,colfr);
        end
else
//�����
if auto_kubik[-1,-1,0].elem=el then
        begin
          ADD_IN_ROTMAS2(18);
        end
else
if auto_kubik[0,-1,-1].elem=el then
        begin
          ADD_IN_ROTMAS2(17);
        end;

//2 ��������
if (auto_kubik[0,-1,1].elem=el) then
        begin
        if auto_kubik[0,-1,1].FRONT=colfr then
          begin
          var1;
          ADD_IN_ROTMAS2(24);
          end
          else
           begin
           ADD_IN_ROTMAS2(18);ADD_IN_ROTMAS2(24);
           var2;
           end;
        end
else
 if (auto_kubik[1,-1,0].elem=el) then
        begin
        if auto_kubik[1,-1,0].RIGHT=colfr then
          begin
           ADD_IN_ROTMAS2(17);var1;ADD_IN_ROTMAS2(24);
          end
          else
           begin
           ADD_IN_ROTMAS2(24);
           var2;
           end;
        end
end;
//4 ����
procedure P4;
  procedure var1;
  begin
  //��2-�'-��'-�2-��-�'-��2
   ADD_IN_ROTMAS2(3); ADD_IN_ROTMAS2(3);ADD_IN_ROTMAS2(14); ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13);
  ADD_IN_ROTMAS2(3);ADD_IN_ROTMAS2(14); ADD_IN_ROTMAS2(3); ADD_IN_ROTMAS2(3);
  end;
  procedure var2;
  begin
  //��2-�-��'-�2-��-�-��2
   ADD_IN_ROTMAS2(3); ADD_IN_ROTMAS2(3);ADD_IN_ROTMAS2(13); ADD_IN_ROTMAS2(4);ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13);
  ADD_IN_ROTMAS2(3);ADD_IN_ROTMAS2(13); ADD_IN_ROTMAS2(3); ADD_IN_ROTMAS2(3);
  end;
  function position(t,b,l:byte):boolean;
  begin
  if (auto_kubik[0,1,-1].elem=t) and (auto_kubik[0,1,1].elem=b) and(auto_kubik[-1,1,0].elem=l)then result:=true else result:=false;
  end;
begin
//�������� 24 ������
//���� �� ���������� ��� ������� ��������� ��������
if position(20,2,12) then exit else
if position(10,12,20) then ADD_IN_ROTMAS2(13) else
if position(2,20,10) then begin ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13) end else
if position(12,10,2) then  ADD_IN_ROTMAS2(14) else
//���� ��� ��������������� �������� ����� � ������ ��������, �� ����� �� ����������
if position(20,2,10) or position(2,20,12)or
   position(2,10,20) or  position(2,12,10) or
   position(20,10,12) or position(20,12,2)then begin ADD_IN_ROTMAS2(13);var1;P4; end else
if position(10,12,2)or position(12,10,20)or position(10,20,2) or  position(12,20,10)or
   position(10,2,12)or position(12,2,20)then begin var1;P4; end else
//��������� ������
if position(20,12,10) then var1 else
if position(20,10,2) then var2 else
if position(12,20,2) then begin ADD_IN_ROTMAS2(23);var2;ADD_IN_ROTMAS2(24); end else
if position(2,12,20) then begin ADD_IN_ROTMAS2(23);var1;ADD_IN_ROTMAS2(24); end else
if position(2,10,12) then begin ADD_IN_ROTMAS2(24);var2;ADD_IN_ROTMAS2(23); end else
if position(10,20,12) then begin ADD_IN_ROTMAS2(24);var1;ADD_IN_ROTMAS2(23); end else
if position(12,2,10) then begin ADD_IN_ROTMAS2(24);ADD_IN_ROTMAS2(24);var2;ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23); end else
if position(10,2,20) then begin ADD_IN_ROTMAS2(24);ADD_IN_ROTMAS2(24);var1;ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23); end else
end;
//����� 5
procedure P5;
//��� ��������
  procedure var1;
  begin
    //(�-��')4-�'-(�-��')4-�
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(14);

    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(13);
  end;
  procedure var2;
  begin
  //(�-��')4-�2-(�-��')4-�2
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13);

    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(16);
    ADD_IN_ROTMAS2(13);ADD_IN_ROTMAS2(13);
  end;
begin
if (auto_kubik[0,1,1].TOP<>@COLOR_BOTTOM)and (auto_kubik[1,1,0].TOP<>@COLOR_BOTTOM) then var1;

if (auto_kubik[0,1,-1].TOP<>@COLOR_BOTTOM)and (auto_kubik[-1,1,0].TOP<>@COLOR_BOTTOM) then
        begin
          ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23);var1;ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23);
        end;

if (auto_kubik[1,1,0].TOP<>@COLOR_BOTTOM)and (auto_kubik[0,1,-1].TOP<>@COLOR_BOTTOM) then
        begin
          ADD_IN_ROTMAS2(24);var1;ADD_IN_ROTMAS2(23);
        end;
if (auto_kubik[0,1,1].TOP<>@COLOR_BOTTOM)and (auto_kubik[-1,1,0].TOP<>@COLOR_BOTTOM) then
        begin
          ADD_IN_ROTMAS2(23);var1;ADD_IN_ROTMAS2(24);
        end;

if (auto_kubik[-1,1,0].TOP<>@COLOR_BOTTOM)and (auto_kubik[1,1,0].TOP<>@COLOR_BOTTOM) then var2;
if (auto_kubik[0,1,-1].TOP<>@COLOR_BOTTOM)and (auto_kubik[0,1,1].TOP<>@COLOR_BOTTOM) then
        begin
          ADD_IN_ROTMAS2(23);var2;ADD_IN_ROTMAS2(24);
        end;
end;
//����� 6
procedure P6;
//��� ��������
  procedure var1;
  begin
    //(�'-�'-�')-(�-�)-(�'-�-�)
    ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(5);
    ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(1);
    ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(7);
  end;
  procedure var2;
  begin
  //(�-�-�)-(�'-�')-(�-�'-�')
    ADD_IN_ROTMAS2(6);ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(1);
    ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(5);
    ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(8);
  end;
begin
//���� ������ �� ����� ������
if (auto_kubik[-1,1,1].elem=3)and(auto_kubik[1,1,1].elem=1)and (auto_kubik[-1,1,-1].elem=21)and(auto_kubik[1,1,-1].elem=19) then exit
else
//���� ������� �� �����
  if (auto_kubik[-1,1,1].elem=3) then
  begin
    if (auto_kubik[1,1,1].elem=21)and (auto_kubik[-1,1,-1].elem=19)and(auto_kubik[1,1,-1].elem=1) then
        begin
         ADD_IN_ROTMAS2(24);var1;
        end else
    if (auto_kubik[1,1,1].elem=19)and (auto_kubik[-1,1,-1].elem=1)and(auto_kubik[1,1,-1].elem=21) then
    begin
     ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23);var2;
    end;
  end
else
if (auto_kubik[1,1,1].elem=1) then
  begin
    if (auto_kubik[-1,1,1].elem=21)and (auto_kubik[-1,1,-1].elem=19)and(auto_kubik[1,1,-1].elem=3) then
        begin
         ADD_IN_ROTMAS2(23);ADD_IN_ROTMAS2(23);var1;
        end else
    if (auto_kubik[-1,1,1].elem=19)and (auto_kubik[-1,1,-1].elem=3)and(auto_kubik[1,1,-1].elem=21) then
    begin
     ADD_IN_ROTMAS2(23);var2;
    end;
  end
else /////////////
if (auto_kubik[-1,1,-1].elem=21) then
  begin
    if (auto_kubik[-1,1,1].elem=19)and(auto_kubik[1,1,1].elem=3)and(auto_kubik[1,1,-1].elem=1) then
        begin
         var1;
        end else
    if(auto_kubik[-1,1,1].elem=1)and(auto_kubik[1,1,1].elem=19)and(auto_kubik[1,1,-1].elem=3) then
    begin
     ADD_IN_ROTMAS2(24);var2;
    end;
  end
else
if (auto_kubik[1,1,-1].elem=19) then
  begin
    if (auto_kubik[-1,1,1].elem=21)and(auto_kubik[1,1,1].elem=3)and (auto_kubik[-1,1,-1].elem=1)then
        begin
         ADD_IN_ROTMAS2(23);var1;
        end else
    if (auto_kubik[-1,1,1].elem=1)and(auto_kubik[1,1,1].elem=21)and (auto_kubik[-1,1,-1].elem=3) then
    begin
     var2;
    end;
  end
//���� ��� ����������
else
  begin
  var1;P6;
  end;
end;
//����� 7
procedure P7;
var i:byte;
//��� ��������
  procedure var1;
  begin
    //(�'-�-�-�')2
    ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(2);
    ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(7);ADD_IN_ROTMAS2(2);
  end;
  procedure var2;
  begin
  //(�-�'-�'-�)2
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(7);
    ADD_IN_ROTMAS2(1);ADD_IN_ROTMAS2(8);ADD_IN_ROTMAS2(2);ADD_IN_ROTMAS2(7);
  end;
begin
for i:=0 to 3 do
  begin
    if auto_kubik[1,1,1].RIGHT=@COLOR_BOTTOM then var1
          else if auto_kubik[1,1,1].Front=@COLOR_BOTTOM then var2;
    ADD_IN_ROTMAS2(14);
  end;
end;
begin
//��������� ������� ��������
NEXT_ROTATE:=false;
//�������� ���������� ��������, ������� ����� ����� �����
auto_kubik:=KUBIK;
//� ��� ������� ��������
ADD_IN_AUTO_ROTMAS(0);
//��������� � ��������� - ������ �����, ����� - ����� (� ���������� �� ��������� ��������������� ���������)
if auto_kubik[0,0,1].FRONT=@COLOR_TOP then ADD_IN_ROTMAS2(21)
 else if auto_kubik[0,0,-1].BACK=@COLOR_TOP then ADD_IN_ROTMAS2(22)
   else if auto_kubik[-1,0,0].LEFT=@COLOR_TOP then ADD_IN_ROTMAS2(19)
   else if auto_kubik[1,0,0].RIGHT=@COLOR_TOP then ADD_IN_ROTMAS2(20)
   else if auto_kubik[0,-1,0].BOTTOM=@COLOR_TOP then begin ADD_IN_ROTMAS2(21);ADD_IN_ROTMAS2(21);end;
if auto_kubik[0,0,-1].BACK=@COLOR_FRONT then begin ADD_IN_ROTMAS2(24);ADD_IN_ROTMAS2(24) end
   else if auto_kubik[-1,0,0].LEFT=@COLOR_FRONT then ADD_IN_ROTMAS2(23)
   else if auto_kubik[1,0,0].RIGHT=@COLOR_FRONT then ADD_IN_ROTMAS2(24);
//������ ������� �����
if not(kubik_is_ok(auto_kubik)) then
begin
//����� 1 - ��������� �������� �� ������� �����
P1(8,@COLOR_FRONT);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P1(18,@COLOR_RIGHT);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P1(26,@COLOR_BACK);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P1(16,@COLOR_LEFT);
//����� - � ��������� ���������
ADD_IN_ROTMAS2(24);
//������ ������� �����

//����� 2 - ��������� ����� ������� �����
P2(9,@COLOR_FRONT,@COLOR_TOP);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P2(27,@COLOR_RIGHT,@COLOR_TOP);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P2(25,@COLOR_BACK,@COLOR_TOP);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
P2(7,@COLOR_LEFT,@COLOR_TOP);
//��������� ����� ����� � ���
ADD_IN_ROTMAS2(24);
//������ �������� �����

//����� 3 - ��������� ������� ��������� ������� �����
P3(6,@COLOR_FRONT);
P3(24,@COLOR_RIGHT);
P3(22,@COLOR_BACK);
P3(4,@COLOR_LEFT);
//������ ��������� �����
//����� 4 - ��������� �������� �� ���������� �����
ADD_IN_ROTMAS2(20);
ADD_IN_ROTMAS2(20);
P4;
//������ ������ �����
//����� 5 - �������������� ������� �������
P5;
//������ ������� �����
//����� 6 - ����������� ������� �������  }
P6;
//������ �������� �����
//����� 7 - �������������� ���������� �������
//������ ��������
P7;
//��������� � ��������� - ������ �����, ����� - �����
if auto_kubik[0,0,1].FRONT=@COLOR_TOP then ADD_IN_ROTMAS2(21)
 else if auto_kubik[0,0,-1].BACK=@COLOR_TOP then ADD_IN_ROTMAS2(22)
   else if auto_kubik[-1,0,0].LEFT=@COLOR_TOP then ADD_IN_ROTMAS2(19)
   else if auto_kubik[1,0,0].RIGHT=@COLOR_TOP then ADD_IN_ROTMAS2(20)
   else if auto_kubik[0,-1,0].BOTTOM=@COLOR_TOP then begin ADD_IN_ROTMAS2(21);ADD_IN_ROTMAS2(21);end;

if auto_kubik[0,0,-1].BACK=@COLOR_FRONT then begin ADD_IN_ROTMAS2(24);ADD_IN_ROTMAS2(24) end
   else if auto_kubik[-1,0,0].LEFT=@COLOR_FRONT then ADD_IN_ROTMAS2(23)
   else if auto_kubik[1,0,0].RIGHT=@COLOR_FRONT then ADD_IN_ROTMAS2(24);

//���������� 4 ���������������� ���������� ��������
povtor:=1;
//���� ��� ���� ��� ���������
while povtor<>0 do
  begin
  povtor:=0;
  //���������� ��� ��������� ��������
  for j:=1 to 24 do  
  for i:=0 to length (auto_rotates_mas)-5 do
    begin
     if (auto_rotates_mas[i]=auto_rotates_mas[i+1]) and
        (auto_rotates_mas[i]=auto_rotates_mas[i+2]) and 
        (auto_rotates_mas[i]=auto_rotates_mas[i+3]) then
         begin
           for k := i to length (auto_rotates_mas)-5 do  auto_rotates_mas[k]:=auto_rotates_mas[k+4];
           SetLength(auto_rotates_mas,length(auto_rotates_mas)-4);
         end;
    end;
  end;
end;

{
 //������� ���������
ADD_IN_ROTMAS(0);
ADD_IN_AUTO_ROTMAS(0);
KUBIK:=auto_kubik;
InvalidateRect(frmGL.Handle, nil, false);
}
//���������
if not edit_mode  then
begin
//��������� ������� ��������
end else KUBIK:=auto_kubik;
end;

end.

