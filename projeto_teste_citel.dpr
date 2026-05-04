program projeto_teste_citel;

uses
  Vcl.Forms,
  UConnection.DataModule in 'src\common\UConnection.DataModule.pas' {dmConnection: TDataModule},
  UCliente.Model in 'src\model\UCliente.Model.pas',
  UCliente.Repository in 'src\repository\UCliente.Repository.pas',
  UProduto.Model in 'src\model\UProduto.Model.pas',
  UProduto.Repository in 'src\repository\UProduto.Repository.pas',
  UItemPedido.Model in 'src\model\UItemPedido.Model.pas',
  UPedido.Model in 'src\model\UPedido.Model.pas',
  UPedido.Repository in 'src\repository\UPedido.Repository.pas',
  UPedido.View in 'src\view\UPedido.View.pas' {frmPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConnection, dmConnection);
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.Run;

end.
