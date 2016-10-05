unit HeaderFooterFormwithNavigation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView,
  Data.Bind.GenData, IPPeerClient, Data.DB, REST.Client, MARS.Client.Client,
  REST.Response.Adapter, Data.Bind.DBScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ScrollBox, FMX.Memo, Datasnap.DBClient, FMX.Ani;

type
  TmCoolnection = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    btnBack: TSpeedButton;
    ToolBarLabel: TLabel;
    btnNext: TSpeedButton;
    tbcMain: TTabControl;
    tbLogin: TTabItem;
    BottomToolBar: TToolBar;
    tbProduct: TTabItem;
    edtUserName: TEdit;
    btnLogin: TCornerButton;
    rclProducts: TRESTClient;
    lvProducts: TListView;
    rrpProducts: TRESTResponse;
    rrqProducts: TRESTRequest;
    bnd1: TBindingsList;
    adpProducts: TRESTResponseDataSetAdapter;
    lnkPrNam1: TLinkFillControlToField;
    imgLogin: TImage;
    Panel1: TPanel;
    styCool: TStyleBook;
    flanimLogo: TFloatAnimation;
    rclLogin: TRESTClient;
    rrqLogin: TRESTRequest;
    rrpLogin: TRESTResponse;
    dsProducts: TClientDataSet;
    dsProductsID: TWideStringField;
    dsProductsName: TWideStringField;
    dsProductsDescription: TWideStringField;
    dsProductsPrice: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnLoginClick(Sender: TObject);
    procedure tbcMainChange(Sender: TObject);
    procedure lvProductsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    FLoginId: Integer;
    FName: string;
    function GetUserInfos(Login: string): integer;
    procedure ConfigureProductPage;
    { Private declarations }
  public
    procedure ConfigureInterfaceForLoginPage;
    procedure LoadProducts;
    procedure ConfigurePages;
  end;

var
  mCoolnection: TmCoolnection;

implementation

uses
  System.JSON;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TmCoolnection.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TbcMain.ActiveTab <> nil then
      TCustomAction(Sender).Text := TbcMain.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure TmCoolnection.btnLoginClick(Sender: TObject);
begin
  FLoginId := GetUserInfos(Trim(LowerCase(edtUserName.Text)));
  LoadProducts;
  tbcMain.ActiveTab := tbProduct;
end;

procedure TmCoolnection.ConfigureInterfaceForLoginPage;
var
  IsPageControl: Boolean;
begin
  IsPageControl := tbcMain.ActiveTab = tbLogin;

  if not IsPageControl then
    Exit;

  btnBack.Visible := False;
  btnNext.Visible := False;
  ToolBarLabel.Visible := False;
  TopToolBar.Visible := False;
  BottomToolBar.Visible := False;
end;

procedure TmCoolnection.ConfigurePages;
begin
  ConfigureInterfaceForLoginPage;
  ConfigureProductPage;
end;

procedure TmCoolnection.ConfigureProductPage;
var
  IsOnPage: Boolean;
begin
  IsOnPage := tbcMain.ActiveTab = tbProduct;
  if not IsOnPage then
    Exit;

  btnBack.Visible := False;
  btnNext.Visible := False;
  ToolBarLabel.Visible := True;
  TopToolBar.Visible := True;
  BottomToolBar.Visible := True;
  ToolBarLabel.Text := 'Welcome ' + FName;
end;

procedure TmCoolnection.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TbcMain.First(TTabTransition.None);
  ConfigurePages;
end;

procedure TmCoolnection.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (TbcMain.TabIndex <> 0) then
  begin
    TbcMain.First;
    Key := 0;
  end;
end;

function TmCoolnection.GetUserInfos(Login: string): integer;
begin
  FName := Login;
  rclLogin.BaseURL := 'http://localhost:8080/rest/cb/user/getonebyname/' + Login;
  rrqLogin.Execute;
  Result := StrToInt((rrpLogin.JSONValue as TJsonObject).GetValue('ID').Value);
end;

procedure TmCoolnection.LoadProducts;
begin
  rrqProducts.Execute;
end;

procedure TmCoolnection.lvProductsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  AItem.Detail := BindSourceDB1.DataSet.FieldByName('ID').AsString;
end;

procedure TmCoolnection.tbcMainChange(Sender: TObject);
begin
  ConfigurePages;
end;

end.
