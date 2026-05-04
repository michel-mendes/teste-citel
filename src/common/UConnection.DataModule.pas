unit UConnection.DataModule;

interface

uses
  VCL.Forms, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, System.IniFiles;

type
  TdmConnection = class(TDataModule)
    Connection: TFDConnection;
    WaitCursor: TFDGUIxWaitCursor;
    DriverLink: TFDPhysMySQLDriverLink;
    Transaction: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConnection: TdmConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConnection.DataModuleCreate(Sender: TObject);
begin
  DriverLink.VendorLib := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';

  Connection.Params.DriverID := 'MySQL';
  Connection.Params.Database := 'teste_citel_michel_mendes';
  Connection.Params.UserName := 'USUARIO_DO_BANCO_AQUI';
  Connection.Params.Password := 'SENHA_DO_BANCO_AQUI';
  Connection.Params.Add('Server=localhost');

  try
    Connection.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar ao banco de dados:' + E.Message);
  end;
end;

end.
