unit UPedido.Repository;

interface

uses
  FireDAC.Comp.Client, UPedido.Model, UItemPedido.Model, System.SysUtils,
  Vcl.Dialogs;

type
  TPedidoRepository = class
  private
    FQuery: TFDQuery;
    function RetornaUltimoIDIncremental: Integer;
  public
    constructor Create(Conn: TFDConnection);
    destructor Destroy; override;

    function GravarPedido(DadosPedido: TPedido): Boolean;
    function PedidoExiste(NumeroPedido: Integer): Boolean;
    function CarregarPedido(NumeroPedido: Integer): TPedido;
    function ApagarPedido(NumeroPedido: Integer): Boolean;
  public
  end;

implementation

constructor TPedidoRepository.Create(Conn: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Conn;
end;

destructor TPedidoRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TPedidoRepository.RetornaUltimoIDIncremental: Integer;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT LAST_INSERT_ID()';
  FQuery.Open;

  Result := FQuery.Fields[0].AsInteger;
end;

function TPedidoRepository.GravarPedido(DadosPedido: TPedido): Boolean;
var
  Item: TItemPedido;
  NumeroNovoPedido: Integer;
begin
  Result := False;

  FQuery.Connection.StartTransaction;

  try
    // Primeiramente insere-se o pedido/venda
    FQuery.SQL.Text := 'INSERT INTO pedidos(data_emissao, codigo_cliente, valor_total)' +
      'VALUES (:data, :codigoCliente, :vrTotal)';
    FQuery.ParamByName('data').AsDateTime := DadosPedido.DataEmissao;
    FQuery.ParamByName('codigoCliente').AsInteger := DadosPedido.CodigoCliente;
    FQuery.ParamByName('vrTotal').AsCurrency := DadosPedido.ValorTotal;
    FQuery.ExecSQL;

    NumeroNovoPedido := RetornaUltimoIDIncremental;

    // Após venda/pedido inseridos, adicionamos cada item fazendo refer}Encia ao pedido
    FQuery.SQL.Text :=
      'INSERT INTO itens_pedido (numero_pedido, codigo_produto, quantidade, vr_unitario, vr_total)'
      + 'VALUES (:numPed, :codProd, :qtde, :vrUnit, :vrTotal)';

    for Item in DadosPedido.ItensPedido do
    begin
      FQuery.ParamByName('numPed').AsInteger := NumeroNovoPedido;
      FQuery.ParamByName('codProd').AsInteger := Item.CodigoProduto;
      FQuery.ParamByName('qtde').AsFloat := Item.Quantidade;
      FQuery.ParamByName('vrUnit').AsCurrency := Item.VrUnitario;
      FQuery.ParamByName('vrTotal').AsCurrency := Item.VrTotal;
      FQuery.ExecSQL
    end;

    FQuery.Connection.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise Exception.Create('Erro ao gravar pedido: ' + E.Message);
    end;
  end;
end;

function TPedidoRepository.PedidoExiste(NumeroPedido: Integer): Boolean;
var
  PedidoExiste: Boolean;
begin
  PedidoExiste := False;

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM pedidos WHERE numero_pedido = :numPed;';
  FQuery.ParamByName('numPed').AsInteger := NumeroPedido;
  FQuery.Open;

  if FQuery.Eof then
    Exit;

  PedidoExiste := True;
  Result := PedidoExiste;
end;

function TPedidoRepository.CarregarPedido(NumeroPedido: Integer): TPedido;
var
  Pedido: TPedido;
  ItemPedido: TItemPedido;
begin
  Pedido := nil;

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT * FROM pedidos WHERE numero_pedido = :numPed;';
  FQuery.ParamByName('numPed').AsInteger := NumeroPedido;
  FQuery.Open;

  if FQuery.Eof then
    Exit;

  try
    Pedido := TPedido.Create;

    Pedido.NumeroPedido := FQuery.FieldByName('numero_pedido').AsInteger;
    Pedido.DataEmissao := FQuery.FieldByName('data_emissao').AsDateTime;
    Pedido.CodigoCliente := FQuery.FieldByName('codigo_cliente').AsInteger;
    Pedido.ValorTotal := FQuery.FieldByName('valor_total').AsCurrency;

    // Buscar os itens para carregamento no pesdido
    FQuery.Close;
    FQuery.SQL.Text :=
      'SELECT iped.codigo, iped.codigo_produto, prod.descricao, iped.quantidade, iped.vr_unitario, iped.vr_total ' + 'FROM itens_pedido iped ' +
      'INNER JOIN produtos prod ON (prod.codigo = iped.codigo_produto) ' +
      'WHERE iped.numero_pedido = :numPed ' +
      'ORDER BY iped.codigo';
    FQuery.ParamByName('numPed').AsInteger := NumeroPedido;
    FQuery.Open;

    while not FQuery.Eof do
    begin
      ItemPedido := TItemPedido.Create;

      ItemPedido.Codigo := FQuery.FieldByName('codigo').AsInteger;
      ItemPedido.NumeroPedido:= NumeroPedido;
      ItemPedido.CodigoProduto := FQuery.FieldByName('codigo_produto').AsInteger;
      ItemPedido.DescricaoProduto := FQuery.FieldByName('descricao').AsString;
      ItemPedido.Quantidade := FQuery.FieldByName('quantidade').AsFloat;
      ItemPedido.VrUnitario := FQuery.FieldByName('vr_unitario').AsCurrency;
      ItemPedido.VrTotal := FQuery.FieldByName('vr_total').AsCurrency;

      Pedido.ItensPedido.Add(ItemPedido);
      FQuery.Next;
    end;
  except
    on E: Exception do
    begin
      FreeAndNil(Pedido);
      raise Exception.Create('Erro ao carregar dados do pedido: ' + E.Message);
    end;
  end;

  Result := Pedido;
end;

function TPedidoRepository.ApagarPedido(NumeroPedido: Integer): Boolean;
begin
  Result := False;

  FQuery.Connection.StartTransaction;

  try
    FQuery.SQL.Text := 'DELETE FROM pedidos WHERE numero_pedido = :numPed';
    FQuery.ParamByName('numPed').AsInteger := NumeroPedido;
    FQuery.ExecSQL;

    FQuery.Connection.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise Exception.Create('Erro ao apagar pedido: ' + E.Message);
    end;
  end;
end;

end.
