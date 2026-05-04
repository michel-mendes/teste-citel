object dmConnection: TdmConnection
  OnCreate = DataModuleCreate
  Height = 308
  Width = 157
  object Connection: TFDConnection
    Transaction = Transaction
    Left = 56
    Top = 24
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 152
  end
  object DriverLink: TFDPhysMySQLDriverLink
    Left = 56
    Top = 88
  end
  object Transaction: TFDTransaction
    Connection = Connection
    Left = 56
    Top = 216
  end
end
