unit UProduto.Repository;

interface

uses
  FireDAC.DApt, FireDAC.Comp.Client, System.Generics.Collections, UProduto.Model;

type
  TProdutoRepository = class
  private
    FQuery: TFDQuery;
  public
    constructor Create(Conn: TFDConnection);
    destructor Destroy; override;

    function BuscaPorCodigo(Codigo: Integer): TProduto;
  end;

implementation

constructor TProdutoRepository.Create(Conn: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Conn;
end;

destructor TProdutoRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TProdutoRepository.BuscaPorCodigo(Codigo: Integer): TProduto;
var
  Produto: TProduto;
begin
  Produto := nil;

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM produtos WHERE codigo = :codigo;';
  FQuery.ParamByName('codigo').AsInteger := Codigo;
  FQuery.Open;

  if not FQuery.Eof then
  begin
    Produto := TProduto.Create;
    Produto.Codigo := FQuery.FieldByName('codigo').AsInteger;
    Produto.Descricao := FQuery.FieldByName('descricao').AsString;
    Produto.PrecoVenda := FQuery.FieldByName('preco_venda').AsCurrency;
  end;

  Result := Produto;
end;

end.
