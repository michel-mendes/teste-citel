unit UCliente.Repository;

interface

uses
  FireDAC.DApt, FireDAC.Comp.Client, System.Generics.Collections, UCliente.Model;

type
  TClienteRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Conn: TFDConnection);
    destructor Destroy; override;

    function BuscaPorCodigo(Codigo: Integer): TCliente;
  end;

implementation

constructor TClienteRepository.Create(Conn: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Conn;
end;

destructor TClienteRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TClienteRepository.BuscaPorCodigo(Codigo: Integer): TCliente;
var
  Cliente: TCliente;
begin
  Cliente := nil;

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM clientes WHERE codigo = :codigo;';
  FQuery.ParamByName('codigo').AsInteger := Codigo;
  FQuery.Open;

  if not FQuery.Eof then
  begin
    Cliente := TCliente.Create;
    Cliente.Codigo := FQuery.FieldByName('codigo').AsInteger;
    Cliente.Nome := FQuery.FieldByName('nome').AsString;
    Cliente.Cidade := FQuery.FieldByName('cidade').AsString;
    Cliente.Uf := FQuery.FieldByName('uf').AsString;
  end;

  Result := Cliente;
end;

end.
