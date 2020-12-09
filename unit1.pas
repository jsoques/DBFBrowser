unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, dbf, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, DbCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    Dbf1: TDbf;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  filename: string;
  title: string;
  col: TColumn;
  count: integer;
begin

  if Button1.Caption = 'Open DBF' then
  begin
       if OpenDialog1.Execute then
       begin
         Dbf1.Active:=false;
         filename := ExtractFileName(OpenDialog1.Filename);
         Dbf1.FilePathFull:=ExtractFilePath(OpenDialog1.FileName);
         Dbf1.TableName:=filename;
         Dbf1.Active:=true;
         //ShowMessage(IntToStr(DBGrid1.Columns.Count));
         for count :=0 to DBGrid1.Columns.Count - 1 do
         begin
           col := DBGrid1.Columns.Items[count];
           if col.Field.ToString = 'TFloatField' then
           begin
              //ShowMessage(col.DisplayName);
              col.DisplayFormat:= '#,###.00';
           end;
         end;
         title := 'DBF Browser';
         Self.Caption:=title + ' File: ' + filename;
         //ShowMessage(filename);
         Button1.Caption := 'Close DBF';
       end;
  end
  else
      begin
        Dbf1.Active:=false;
        Dbf1.Close;
        Button1.Caption := 'Open DBF';
      end;
end;

end.

