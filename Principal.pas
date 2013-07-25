unit Principal;

interface

uses
  Forms, ComCtrls, StdCtrls, Controls, Classes;

type
  TfrmPrincipal = class(TForm)
    lblArchivo: TLabel;
    edtArchivo: TEdit;
    btnArchivo: TButton;
    trvContenido: TTreeView;
    procedure btnArchivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ImportaArchivo(Archivo: string);
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  SysUtils, StrUtils, Dialogs;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  Archivo,
  Extension: string;
begin
  Archivo := ParamStr(1);
  if Archivo <> '' then
  begin
    Extension := ExtractFileExt(Archivo);

    if (Extension = '.sql') or (Extension = '.dump') then
      if FileExists(Archivo) then
        ImportaArchivo(Archivo);
  end;
end;

procedure TfrmPrincipal.ImportaArchivo(Archivo: string);
var
  i, j: Integer;
  Linea: string;
  Contenido: TStringList;
  BaseDatos, Tabla: TTreeNode;
  Campos: Boolean;
begin
  edtArchivo.Text := Archivo;
  trvContenido.Items.Clear;

  Contenido := TStringList.Create;
  try
    j := -1; // Para mostrar que no se ha leído línea alguna
    try
      Contenido.LoadFromFile(Archivo);

      BaseDatos := nil;
      Tabla := nil;
      Campos := False;
      for i := 0 to Contenido.Count - 1 do
      begin
        Linea := Contenido[i];

        if Pos('-- Current Database:', Linea) = 1 then
        begin
          BaseDatos := trvContenido.Items.AddChild(nil,
            Copy(Linea, Pos('`', Linea) + 1,
              PosEx('`', Linea, Pos('`', Linea) + 1) - Pos('`', Linea) - 1));
        end
        else
          if Pos('-- Table structure for table', Linea) = 1 then
          begin
            Tabla := trvContenido.Items.AddChild(BaseDatos,
              Copy(Linea, Pos('`', Linea) + 1,
                PosEx('`', Linea, Pos('`', Linea) + 1) - Pos('`', Linea) - 1));

            Campos := False;
          end
        else
          if Pos('CREATE TABLE', Linea) = 1 then
            Campos := True
        else
          if Campos then
          begin
            if Pos(')', Linea) = 1 then
              Campos := False
            else
              trvContenido.Items.AddChild(Tabla,
                Trim(Copy(Linea + ',', 1,
                  PosEx(',', Linea + ',', Length(Linea)) - 1)));
          end;

        j := i; // Para mostrar la línea si existe un error
      end;
    except
      on E: Exception do
        MessageDlg(Format('%s at line %d', [E.Message, j]), mtError, [mbOk], 0);
    end;
  finally
    Contenido.Free;
  end;
end;

procedure TfrmPrincipal.btnArchivoClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
  try
    DefaultExt := '.sql';
    Filter := 'MySQL Dumps (*.sql;*.dump)|*.sql;*.dump';
    if Execute then
      ImportaArchivo(FileName);
  finally
    Free;
  end;
end;

end.
