unit uFormPageSelect2;

interface

uses

 IW.Content.Handlers, IWMimeTypes, System.JSON, uServerController,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompButton, Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompListbox, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait;

type
  TFormPageSelect2 = class(TIWAppForm)
    Template: TIWTemplateProcessorHTML;
    IWComboBox: TIWComboBox;
    BtnOk: TIWButton;
    Conexao: TFDConnection;
    procedure BtnOkAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWComboBoxAsyncChange(Sender: TObject; EventParams: TStringList);
  public
    Codigo : String;
    procedure SQLToJsonSelect2(aParams: TStrings; out aResult: String);
    function fSomenteNumeros(Value : String): Boolean;
  end;

implementation

{$R *.dfm}

procedure TFormPageSelect2.BtnOkAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowAlert('O Código selecionado é: ' + Codigo);
end;

procedure TFormPageSelect2.IWAppFormCreate(Sender: TObject);
begin
  RegisterCallBack(IWCOMBOBOX.Name,SQLToJsonSelect2);
end;

procedure TFormPageSelect2.IWComboBoxAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  Codigo := EventParams.Values['IWCOMBOBOX'];
end;

function TFormPageSelect2.fSomenteNumeros(Value : String): Boolean;
begin
  result := true;
  try
    StrToInt(Value);
  except
    result := false;
  end;
End;

procedure TFormPageSelect2.SQLToJsonSelect2(aParams: TStrings; out aResult: String);
var
  DataRecord : TJSONArray;
  JsonObject, MyJson : TJsonObject;
  i : Integer;
  QrySelect2 : TFDQuery;
  xParam, xSql : string;

begin
  try

    QrySelect2 := TFDQuery.Create(nil);
    QrySelect2.Connection := Conexao;


    xParam := aParams.Values['value'];

    //observação os mesmos fields acionado na consulta deve ser adicionado ao javascript no html
    xSql := 'SELECT COD_PESSOA, PES_RAZAO, PES_CNPJ_CPF FROM PESSOA';

    if xParam <> '' then
    begin
      if fSomenteNumeros(xParam) then
      begin
        if Length(xParam) >= 11 then
          xSql := xSql + ' WHERE PES_CNPJ_CPF = '+ xParam + '%'''
        else
          xSql := xSql + ' WHERE COD_PESSOA ='+ xParam;
      end
      else
        xSql := xSql + ' WHERE ((PES_RAZAO LIKE ''%' + xParam + '%'') OR (PES_FANTASIA LIKE ''%' + xParam+ '%''))';
    end;

    xSql := xSql + ' ORDER BY PES_RAZAO';

    QrySelect2.Close;
    QrySelect2.SQL.Clear;
    QrySelect2.SQL.Text := xSql;
    QrySelect2.Open;

    DataRecord :=  TJSONArray.Create();

    if not QrySelect2.IsEmpty then
    begin
      // Realiza a varredura nas colunas e linha
      QrySelect2.First;
      while not QrySelect2.Eof do
      begin
        MyJson := TJsonObject.Create;

        for i := 0 to QrySelect2.FieldCount-1 do
          MyJson.AddPair(QrySelect2.Fields[i].FieldName, QrySelect2.Fields[i].AsString);

        DataRecord.Add(MyJson);

        QrySelect2.Next;
      end;

    end;

    JsonObject :=  TJsonObject.Create();
    JsonObject.AddPair('results', DataRecord);

    aResult := JsonObject.ToString;
  finally
    QrySelect2.Free;
  end;
end;

initialization
  TFormPageSelect2.SetAsMainForm;

end.
