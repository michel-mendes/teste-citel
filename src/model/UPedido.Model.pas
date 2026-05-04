unit UPedido.Model;

interface

uses
  UItemPedido.Model, System.Generics.Collections, System.SysUtils;

type
  TPedido = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Currency;

    FItensPedido: TObjectList<TItemPedido>;
  public
    constructor Create;
    destructor Destroy; override;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property ItensPedido: TObjectList<TItemPedido> read FItensPedido;
  end;

implementation

constructor TPedido.Create;
begin
  FItensPedido := TObjectList<TItemPedido>.Create;
  FDataEmissao := Now;
end;

destructor TPedido.Destroy;
begin
  FItensPedido.Free;
  inherited;
end;

end.
