object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Lan'#231'amento de Pedido de Venda'
  ClientHeight = 443
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 802
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      802
      97)
    object grpCliente: TGroupBox
      Left = 10
      Top = 10
      Width = 406
      Height = 75
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Dados do Cliente '
      TabOrder = 0
      DesignSize = (
        406
        75)
      object lblCliente: TLabel
        Left = 15
        Top = 25
        Width = 80
        Height = 13
        Caption = 'C'#243'digo (ENTER)'
      end
      object lblNomeCli: TLabel
        Left = 121
        Top = 25
        Width = 84
        Height = 13
        Caption = 'Nome do cliente'
      end
      object edtCodigoCliente: TEdit
        Left = 15
        Top = 44
        Width = 100
        Height = 21
        TabOrder = 0
        OnChange = edtCodigoClienteChange
        OnKeyDown = edtCodigoClienteKeyDown
      end
      object edtNomeCli: TEdit
        Left = 121
        Top = 44
        Width = 272
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
        OnChange = edtCodigoClienteChange
        OnKeyDown = edtCodigoClienteKeyDown
      end
    end
    object grpAcoesIniciais: TGroupBox
      Left = 422
      Top = 10
      Width = 370
      Height = 75
      Anchors = [akTop, akRight]
      Caption = 'Pedidos Gravados '
      TabOrder = 1
      object btnCarregar: TButton
        Left = 20
        Top = 25
        Width = 160
        Height = 35
        Caption = 'Carregar Pedido'
        TabOrder = 0
        OnClick = btnCarregarClick
      end
      object btnApagar: TButton
        Left = 192
        Top = 25
        Width = 160
        Height = 35
        Caption = 'Apagar Pedido'
        TabOrder = 1
        OnClick = btnApagarClick
      end
    end
  end
  object pnlItens: TPanel
    Left = 0
    Top = 97
    Width = 802
    Height = 286
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      802
      286)
    object lblLegendaComandosGrid: TLabel
      Left = 10
      Top = 267
      Width = 221
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '[ENTER] - Alterar item | [DEL] - Excluir item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grpInserirProduto: TGroupBox
      Left = 10
      Top = 0
      Width = 782
      Height = 73
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Itens do Pedido '
      TabOrder = 0
      DesignSize = (
        782
        73)
      object lblProd: TLabel
        Left = 15
        Top = 20
        Width = 38
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblQtd: TLabel
        Left = 471
        Top = 20
        Width = 61
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Quantidade'
      end
      object lblVru: TLabel
        Left = 538
        Top = 20
        Width = 59
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Vr. Unit'#225'rio'
      end
      object lblDescricaoProd: TLabel
        Left = 121
        Top = 20
        Width = 49
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object edtCodigoProd: TEdit
        Left = 15
        Top = 39
        Width = 100
        Height = 21
        TabOrder = 0
        OnKeyDown = edtCodigoProdKeyDown
      end
      object edtQtdProd: TEdit
        Left = 471
        Top = 39
        Width = 61
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 1
        Text = '1'
      end
      object edtVrUnitProd: TEdit
        Left = 538
        Top = 39
        Width = 100
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 2
        Text = '0,00'
      end
      object btnInserirProd: TButton
        Left = 644
        Top = 37
        Width = 120
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Inserir Produto'
        TabOrder = 3
        OnClick = btnInserirProdClick
      end
      object edtDescricaoProd: TEdit
        Left = 121
        Top = 39
        Width = 344
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
        OnKeyDown = edtCodigoProdKeyDown
      end
    end
    object dbgItens: TDBGrid
      Left = 10
      Top = 79
      Width = 782
      Height = 182
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyDown = dbgItensKeyDown
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 383
    Width = 802
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      802
      60)
    object lblTotalPedido: TLabel
      Left = 608
      Top = 15
      Width = 184
      Height = 30
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Total: R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGravar: TButton
      Left = 15
      Top = 10
      Width = 150
      Height = 40
      Caption = 'GRAVAR PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  object mtItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 304
    Top = 238
    object mtItenscodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object mtItensdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 75
    end
    object mtItensquantidade: TFloatField
      DisplayLabel = 'Qtd.'
      FieldName = 'quantidade'
    end
    object mtItensvalor_unitario: TCurrencyField
      DisplayLabel = 'Vr. Unit'#225'rio'
      FieldName = 'valor_unitario'
    end
    object mtItensvalor_total: TCurrencyField
      DisplayLabel = 'Vr. Total'
      FieldName = 'valor_total'
    end
  end
  object dsItens: TDataSource
    DataSet = mtItens
    Left = 384
    Top = 238
  end
end
