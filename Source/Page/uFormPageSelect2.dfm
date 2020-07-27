object FormPageSelect2: TFormPageSelect2
  Left = 0
  Top = 0
  Width = 555
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  Background.Fixed = False
  LayoutMgr = Template
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  DesignLeft = 2
  DesignTop = 2
  object IWComboBox: TIWComboBox
    Left = 32
    Top = 32
    Width = 241
    Height = 21
    Css = 'form-control'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderVisibility = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    OnAsyncChange = IWComboBoxAsyncChange
    TabOrder = 0
    ItemIndex = -1
    FriendlyName = 'IWComboBox'
    NoSelectionText = '-- N'#227'o Selectionado --'
  end
  object BtnOk: TIWButton
    Left = 279
    Top = 28
    Width = 75
    Height = 25
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderVisibility = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'BtnOk'
    Color = clBtnFace
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'BtnOk'
    TabOrder = 1
    OnAsyncClick = BtnOkAsyncClick
  end
  object Template: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'index.html'
    RenderStyles = False
    Left = 456
    Top = 24
  end
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\Commerce\Clientes\07341541000122\BD\DADOS.F' +
        'DB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'Protocol=TCPIP'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 408
    Top = 24
  end
end
