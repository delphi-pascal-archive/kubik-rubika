unit SCENE_PAINT_UNIT;
interface
uses  Windows,OpenGL;
procedure SCENE_PAINT;
implementation
uses FRMMAIN_UNIT, INIT_UNIT;
procedure SCENE_PAINT;
var i,j,k:integer;
begin
//Если в данный момент не происходит смены цветов
if ROT_FLAG then
 for i := -1 to 1 do
      for j := -1 to 1 do
          for k := -1 to 1 do
                  begin
                   glPushMatrix;
                   //Поворот на угол в зависимости от вида вращения
                   case ROTATE_MODE of
                     1:if i=1 then glRotatef(Angle,-1,0,0);
                     2:if i=1 then glRotatef(Angle,1,0,0);
                     3:if i=0 then glRotatef(Angle,-1,0,0);
                     4:if i=0 then glRotatef(Angle,1,0,0);
                     5:if i=-1 then glRotatef(Angle,-1,0,0);
                     6:if i=-1 then glRotatef(Angle,1,0,0);

                     7:if k=1 then glRotatef(Angle,0,0,-1);
                     8:if k=1 then glRotatef(Angle,0,0,1);
                     9:if k=0 then glRotatef(Angle,0,0,-1);
                     10:if k=0 then glRotatef(Angle,0,0,1);
                     11:if k=-1 then glRotatef(Angle,0,0,-1);
                     12:if k=-1 then glRotatef(Angle,0,0,1);

                     13:if j=1 then glRotatef(Angle,0,-1,0);
                     14:if j=1 then glRotatef(Angle,0,1,0);
                     15:if j=0 then glRotatef(Angle,0,-1,0);
                     16:if j=0 then glRotatef(Angle,0,1,0);
                     17:if j=-1 then glRotatef(Angle,0,-1,0);
                     18:if j=-1 then glRotatef(Angle,0,1,0);

                     19: glRotatef(Angle,0,0,-1);
                     20: glRotatef(Angle,0,0,1);
                     21: glRotatef(Angle,-1,0,0);
                     22: glRotatef(Angle,1,0,0);
                     23: glRotatef(Angle,0,1,0);
                     24: glRotatef(Angle,0,-1,0);
                   end;

                   glTranslatef((2*ZOOM+SMESH)*i,(2*ZOOM+SMESH)*j,(2*ZOOM+SMESH)*k);
                   glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_BLACK);
                   if (i=0) and (j=0)and (k=0) then
                   begin
                     glScalef(1.6,1.6,1.65);
                     glCallList(CUBE);
                     glScalef(1/1.6,1/1.6,1/1.6);
                   end else
                begin
                glCallList(CUBE);

          if KUBIK[i,j,k].FRONT_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_FRONT);
            end
            else if KUBIK[i,j,k].FRONT<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].FRONT);
                         glCallList(NAKL_FRONT);
                        end;

           if KUBIK[i,j,k].BACK_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_BACK);
            end
            else
                if KUBIK[i,j,k].BACK<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].BACK);
                         glCallList(NAKL_BACK);
                        end;
           if KUBIK[i,j,k].LEFT_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_LEFT);
            end
            else
               if KUBIK[i,j,k].LEFT<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].LEFT);
                         glCallList(NAKL_LEFT);
                        end ;
           if KUBIK[i,j,k].RIGHT_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_RIGHT);
            end
            else
               if KUBIK[i,j,k].RIGHT<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].RIGHT);
                         glCallList(NAKL_RIGHT);
                        end;
           if KUBIK[i,j,k].TOP_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_TOP);
            end
            else
               if KUBIK[i,j,k].TOP<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].TOP);
                         glCallList(NAKL_TOP);
                        end;
           if KUBIK[i,j,k].BOTTOM_ACTIVE and mig  then
            begin
              glMaterialfv (GL_FRONT, GL_DIFFUSE, @COLOR_MIG);
              glCallList(NAKL_BOTTOM);
            end
            else
               if KUBIK[i,j,k].BOTTOM<>nil then
                        begin
                         glMaterialfv (GL_FRONT, GL_DIFFUSE, KUBIK[i,j,k].BOTTOM);
                         glCallList(NAKL_BOTTOM);
                        end;
               end;

               glPopMatrix;
              end;
end;

end.

