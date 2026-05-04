unit UItemPedido.Model;

interface

type
  TItemPedido = class
  private
    FCodigo: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Double;
    FVrUnitario: Currency;
    FVrTotal: Currency;

    FLookDescricaoProduto: string; // JOIN produto.descricao
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property DescricaoProduto: string read FLookDescricaoProduto write FLookDescricaoProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property VrUnitario: Currency read FVrUnitario write FVrUnitario;
    property VrTotal: Currency read FVrTotal write FVrTotal;
  end;

implementation

end.
