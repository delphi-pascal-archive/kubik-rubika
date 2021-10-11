program Kubik;

uses
  Forms,
  FRMMAIN_UNIT in 'FRMMAIN_UNIT.pas' {frmGL},
  INIT_UNIT in 'INIT_UNIT.pas',
  SCENE_PAINT_UNIT in 'SCENE_PAINT_UNIT.pas',
  COLOR_ROTATE_UNIT in 'COLOR_ROTATE_UNIT.pas',
  OPTIONS_UNIT in 'OPTIONS_UNIT.pas' {OPform},
  SELECT_UNIT in 'SELECT_UNIT.pas',
  AUTOMAT_UNIT in 'AUTOMAT_UNIT.pas',
  ROTTHREAD_UNIT in 'ROTTHREAD_UNIT.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Кубик Рубика';
  Application.CreateForm(TfrmGL, frmGL);
  Application.CreateForm(TOPform, OPform);
  Application.Run;
end.

