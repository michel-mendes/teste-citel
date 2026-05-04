unit UPedido.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UConnection.DataModule, UCliente.Model,
  UCliente.Repository, UItemPedido.Model, UProduto.Model, UProduto.Repository, UPedido.Model,
  UPedido.Repository;

type
  TfrmPedido = class(TForm)
    pnlHeader: TPanel;
    grpCliente: TGroupBox;
    lblCliente: TLabel;
    edtCodigoCliente: TEdit;
    grpAcoesIniciais: TGroupBox;
    btnCarregar: TButton;
    btnApagar: TButton;
    pnlItens: TPanel;
    grpInserirProduto: TGroupBox;
    lblProd: TLabel;
    edtCodigoProd: TEdit;
    lblQtd: TLabel;
    edtQtdProd: TEdit;
    lblVru: TLabel;
    edtVrUnitProd: TEdit;
    btnInserirProd: TButton;
    pnlFooter: TPanel;
    btnGravar: TButton;
    lblTotalPedido: TLabel;
    mtItens: TFDMemTable;
    dsItens: TDataSource;
    mtItenscodigo: TIntegerField;
    mtItensdescricao: TStringField;
    mtItensquantidade: TFloatField;
    mtItensvalor_unitario: TCurrencyField;
    mtItensvalor_total: TCurrencyField;
    dbgItens: TDBGrid;
    lblDescricaoProd: TLabel;
    edtDescricaoProd: TEdit;
    lblNomeCli: TLabel;
    edtNomeCli: TEdit;
    lblLegendaComandosGrid: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoProdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInserirProdClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FClienteRepo: TClienteRepository;
    FProdutoRepo: TProdutoRepository;
    FPedidoRepo: TPedidoRepository;
    FPedidoAtual: TPedido;
    FEditando: Boolean;
    procedure AtualizarTotalGeral;
    procedure LimparCamposProduto;
    procedure BuscarCliente;
    procedure BuscarProduto;
    function ValidaQuantidadeEPrecoUnitario: Boolean;
  public
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  FClienteRepo := TClienteRepository.Create(dmConnection.Connection);
  FProdutoRepo := TProdutoRepository.Create(dmConnection.Connection);
  FPedidoRepo := TPedidoRepository.Create(dmConnection.Connection);
  FPedidoAtual := TPedido.Create;
  FPedidoAtual.CodigoCliente := 0;
  mtItens.CreateDataSet;
  FEditando := False;
end;

procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
  FClienteRepo.Free;
  FProdutoRepo.Free;
  FPedidoRepo.Free;

  FPedidoAtual.Free;
end;

procedure TfrmPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(ActiveControl as TWinControl, true, true);
  end;
end;

procedure TfrmPedido.AtualizarTotalGeral;
var
  LTotal: Currency;
begin
  LTotal := 0;
  mtItens.DisableControls;

  try
    mtItens.First;
    while not mtItens.Eof do
    begin
      LTotal := LTotal + mtItensvalor_total.AsCurrency;
      mtItens.Next;
    end;
  finally
    mtItens.EnableControls;
  end;

  FPedidoAtual.ValorTotal := LTotal;
  lblTotalPedido.Caption := Format('Total: %s', [FormatCurr('R$ #,##0.00', LTotal)]);
end;

procedure TfrmPedido.LimparCamposProduto;
begin
  edtCodigoProd.Clear;
  edtQtdProd.Text := '1';
  edtVrUnitProd.Text := '0,00';
  edtDescricaoProd.Clear;
  FEditando := False;
  edtCodigoProd.Enabled := true;
  edtDescricaoProd.Enabled := true;
  btnInserirProd.Caption := 'Inserir Produto';
  edtCodigoProd.SetFocus;
end;

procedure TfrmPedido.BuscarCliente;
var
  LCliente: TCliente;
begin
  if edtCodigoCliente.Text = '' then
    Exit;

  LCliente := FClienteRepo.BuscaPorCodigo(StrToIntDef(edtCodigoCliente.Text, 0));
  try
    if Assigned(LCliente) then
    begin
      edtNomeCli.Text := LCliente.Nome;
      FPedidoAtual.CodigoCliente := LCliente.Codigo;
    end
    else
    begin
      edtNomeCli.Text := 'CLIENTE NÃO ENCONTRADO';
      FPedidoAtual.CodigoCliente := 0;
    end;
  finally
    LCliente.Free;
  end;
end;

procedure TfrmPedido.BuscarProduto;
var
  LProd: TProduto;
begin
  LProd := FProdutoRepo.BuscaPorCodigo(StrToIntDef(edtCodigoProd.Text, 0));

  try
    if Assigned(LProd) then
    begin
      edtDescricaoProd.Text := LProd.Descricao;
      edtQtdProd.Text := '1';
      edtVrUnitProd.Text := FormatCurr('#,##0.00', LProd.PrecoVenda);
    end
    else
    begin
      ShowMessage('Produto não encontrado.');
      edtCodigoProd.Clear;
      edtDescricaoProd.Clear;
      edtQtdProd.Clear;
      edtVrUnitProd.Clear;
      edtCodigoProd.SetFocus;
      Exit;
    end;
  finally
    LProd.Free;
  end;
end;

function TfrmPedido.ValidaQuantidadeEPrecoUnitario: Boolean;
var
  QuantValida: Double;
  ValorValido: Currency;
begin
  Result := False;

  if not TryStrToFloat(edtQtdProd.Text, QuantValida) then
  begin
    ShowMessage('Quantidade inválida');
    edtQtdProd.Clear;
    edtQtdProd.SetFocus;
    Exit
  end;

  if not TryStrToCurr(edtVrUnitProd.Text, ValorValido) then
  begin
    ShowMessage('Preço inválido');
    edtVrUnitProd.Clear;
    edtVrUnitProd.SetFocus;
    Exit
  end;

  if ((QuantValida < 0) or (ValorValido < 0)) then
  begin
    ShowMessage('Valores ou quantidades negativas não são permitidos');
    Exit;
  end;

  Result := true;
end;

procedure TfrmPedido.edtCodigoClienteChange(Sender: TObject);
begin
  btnCarregar.Visible := edtCodigoCliente.Text = '';
  btnApagar.Visible := edtCodigoCliente.Text = '';
end;

procedure TfrmPedido.edtCodigoClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BuscarCliente;
end;

procedure TfrmPedido.edtCodigoProdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BuscarProduto;
end;

procedure TfrmPedido.btnInserirProdClick(Sender: TObject);
begin
  if (edtCodigoProd.Text = '') then
  begin
    ShowMessage('Informe um produto válido.');
    edtCodigoProd.SetFocus;
    Exit;
  end;

  if not ValidaQuantidadeEPrecoUnitario then
    Exit;

  if FEditando then
    mtItens.Edit
  else
    mtItens.Append;

  mtItenscodigo.AsInteger := StrToInt(edtCodigoProd.Text);
  mtItensdescricao.AsString := edtDescricaoProd.Text;
  mtItensquantidade.AsFloat := StrToFloat(edtQtdProd.Text);
  mtItensvalor_unitario.AsCurrency := StrToCurr(edtVrUnitProd.Text);
  mtItensvalor_total.AsCurrency := mtItensquantidade.AsFloat * mtItensvalor_unitario.AsCurrency;
  mtItens.Post;

  AtualizarTotalGeral;
  LimparCamposProduto;
end;

procedure TfrmPedido.dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  // Alterar o item focado no grid
  if (Key = VK_RETURN) and (not mtItens.IsEmpty) then
  begin
    FEditando := true;
    edtCodigoProd.Text := mtItenscodigo.AsString;
    edtDescricaoProd.Text := mtItensdescricao.AsString;
    edtQtdProd.Text := mtItensquantidade.AsString;
    edtVrUnitProd.Text := FormatCurr('#,##0.00', mtItensvalor_unitario.AsCurrency);
    edtCodigoProd.Enabled := False;
    edtDescricaoProd.Enabled := False;
    btnInserirProd.Caption := 'Confirmar Alteração';
    edtQtdProd.SetFocus;
  end;

  // Apagar o item focado no grid
  if (Key = VK_DELETE) and (not mtItens.IsEmpty) then
  begin
    if MessageDlg('Deseja realmente remover este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
    begin
      mtItens.Delete;
      AtualizarTotalGeral;
    end;
  end;
end;

procedure TfrmPedido.btnGravarClick(Sender: TObject);
var
  LItem: TItemPedido;
begin
  if mtItens.IsEmpty then
  begin
    ShowMessage('O pedido deve conter ao menos um item.');
    Exit;
  end;

  try
    if FPedidoAtual.CodigoCliente = 0 then
    begin
      ShowMessage('Informe o cliente para gravar a venda');
      Exit;
    end;

    mtItens.First;
    while not mtItens.Eof do
    begin
      LItem := TItemPedido.Create;
      LItem.CodigoProduto := mtItenscodigo.AsInteger;
      LItem.Quantidade := mtItensquantidade.AsFloat;
      LItem.VrUnitario := mtItensvalor_unitario.AsCurrency;
      LItem.VrTotal := mtItensvalor_total.AsCurrency;
      FPedidoAtual.ItensPedido.Add(LItem);
      mtItens.Next;
    end;

    if FPedidoRepo.GravarPedido(FPedidoAtual) then
    begin
      ShowMessage('Pedido gravado com sucesso!');
      mtItens.EmptyDataSet;
      edtCodigoCliente.Clear;
      AtualizarTotalGeral;
    end;
  finally
    FPedidoAtual.Free;
    FPedidoAtual := TPedido.Create;
  end;
end;

procedure TfrmPedido.btnCarregarClick(Sender: TObject);
var
  LNum: string;
  LPedido: TPedido;
  LItemPedido: TItemPedido;
begin
  LNum := InputBox('Carregar Pedido', 'Informe o número do pedido:', '');

  if (LNum <> '') and (FPedidoRepo.PedidoExiste(StrToIntDef(LNum, 0))) then
  begin
    LPedido := FPedidoRepo.CarregarPedido(StrToInt(LNum));

    try
      mtItens.EmptyDataSet;

      edtCodigoCliente.Text := LPedido.CodigoCliente.ToString;
      BuscarCliente;

      mtItens.DisableControls;
      try
        for LItemPedido in LPedido.ItensPedido do
        begin
          mtItens.Append;

          mtItenscodigo.AsInteger := LItemPedido.CodigoProduto;
          mtItensdescricao.AsString := LItemPedido.DescricaoProduto;
          mtItensquantidade.AsFloat := LItemPedido.Quantidade;
          mtItensvalor_unitario.AsCurrency := LItemPedido.VrUnitario;
          mtItensvalor_total.AsCurrency := LItemPedido.VrTotal;

          mtItens.Post;
        end;
      finally
        mtItens.EnableControls
      end;

      AtualizarTotalGeral;
      ShowMessage('O pedido nº ' + LNum + ' de ' + edtNomeCli.Text + ' foi carregado com sucesso!');
    finally
      if Assigned(LPedido) then
        LPedido.Free;
    end;
  end
  else
    ShowMessage('Pedido não localizado!');
end;

procedure TfrmPedido.btnApagarClick(Sender: TObject);
var
  LNum: string;
begin
  LNum := InputBox('Apagar Pedido', 'Informe o número do pedido para EXCLUSÃO:', '');

  if (LNum <> '') and (FPedidoRepo.PedidoExiste(StrToIntDef(LNum, 0))) and
    (FPedidoRepo.ApagarPedido(StrToIntDef(LNum, 0))) then
    ShowMessage('Pedido excluído com sucesso!')
  else
    ShowMessage('Pedido não localizado!');
end;

end.
