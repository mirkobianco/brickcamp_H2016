unit HeaderFooterFormwithNavigation;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView,
  Data.Bind.GenData, IPPeerClient, REST.Client, MARS.Client.Client,
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
    lvProducts: TListView;
    bndList: TBindingsList;
    imgLogin: TImage;
    Panel1: TPanel;
    styCool: TStyleBook;
    flanimLogo: TFloatAnimation;
    bndProducts: TBindSourceDB;
    tbQuestions: TTabItem;
    lblBottom: TLabel;
    lblProductId: TLabel;
    LinkFillControlToPropertyText: TLinkFillControlToProperty;
    pnlCreateQuestion: TPanel;
    lblCreateQuestion: TLabel;
    tbCreateQuestion: TTabItem;
    pnlCreateQuestionYesNo: TPanel;
    pnlCancel: TPanel;
    pnlYes: TPanel;
    lblCreateNo: TLabel;
    lblCreateYes: TLabel;
    mmoAskQuestion: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnLoginClick(Sender: TObject);
    procedure tbcMainChange(Sender: TObject);
    procedure lvProductsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure pnlCreateQuestionClick(Sender: TObject);
    procedure pnlCancelClick(Sender: TObject);
  private
    FUserId: Integer;
    FName: string;
    FProductDataSet: TClientDataSet;
    FProductId: Integer;
    FProductDesc: string;
    FProductName: string;
    function GetUserInfos(Login: string): integer;

    procedure ConfigureProductPage;
    procedure ConfigureLoginPage;
    procedure ConfigurePageQuestions;
    procedure ConfigureCreateQuestion;
    procedure ChangeMemoColor(Memo: TMemo);
  public
    procedure LoadProducts;
    procedure LoadQuestions;
    procedure ConfigurePages;
  end;

var
  mCoolnection: TmCoolnection;

implementation

uses
  System.JSON, BrickCamp.RemoteInterface, Data.DB, System.UITypes,
  System.UIConsts,
  BrickCamp.Model;

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
  FUserId := GetUserInfos(Trim(LowerCase(edtUserName.Text)));
  LoadProducts;
  tbcMain.ActiveTab := tbProduct;
end;

procedure TmCoolnection.ConfigureCreateQuestion;
var
  IsOnPage: Boolean;
begin
  IsOnPage := tbcMain.ActiveTab = tbCreateQuestion;
  if not IsOnPage then
    Exit;

  btnBack.Visible := True;
  btnNext.Visible := False;
  ToolBarLabel.Visible := True;
  TopToolBar.Visible := True;
  BottomToolBar.Visible := True;
  lblBottom.Visible := True;

  ToolBarLabel.Text := 'How can we help help you ? :D';
  lblBottom.Text := 'Product ' + FProductName + ' - ' + FProductDesc;
end;

procedure TmCoolnection.ConfigureLoginPage;
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

procedure TmCoolnection.ConfigurePageQuestions;
var
  IsOnPage: Boolean;
begin
  IsOnPage := tbcMain.ActiveTab = tbQuestions;
  if not IsOnPage then
    Exit;

  btnBack.Visible := True;
  btnNext.Visible := False;
  ToolBarLabel.Visible := True;
  TopToolBar.Visible := True;
  BottomToolBar.Visible := True;
  lblBottom.Visible := True;

  ToolBarLabel.Text := 'Product ' + FProductName;
  lblBottom.Text := FProductDesc;
end;

procedure TmCoolnection.ConfigurePages;
begin
  ConfigureLoginPage;
  ConfigureProductPage;
  ConfigurePageQuestions;
  ConfigureCreateQuestion;
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
  BottomToolBar.Visible := False;
  lblBottom.Visible := False;

  ToolBarLabel.Text := 'Welcome ' + FName;
end;

procedure TmCoolnection.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TbcMain.First(TTabTransition.None);
  ChangeMemoColor(mmoAskQuestion);
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
var
  Brick: TBrickCampRemoteInterface;
begin
  Brick := TBrickCampRemoteInterface.Create;
  try
    FUserId := Brick.LoginUser(Login);
    bndProducts.DataSet := FProductDataSet;
  finally
    Brick.Free;
  end;
  FName := Login;
end;

procedure TmCoolnection.LoadProducts;
var
  Brick: TBrickCampRemoteInterface;
begin
  Brick := TBrickCampRemoteInterface.Create;
  try
    FProductDataSet := Brick.GetDataset(rProduct);
    bndProducts.DataSet := FProductDataSet;
  finally
    Brick.Free;
  end;
end;

procedure TmCoolnection.LoadQuestions;
var
  Brick: TBrickCampRemoteInterface;
  ProductId: Integer;
begin
  Brick := TBrickCampRemoteInterface.Create;
  try
    bndProducts.DataSet := Brick.GetQuestionsByProduct(ProductId);
  finally
    Brick.Free;
  end;

end;

procedure TmCoolnection.lvProductsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FProductDataSet.Locate('ID', StrToInt(lblProductId.Text), []);

  FProductId := FProductDataSet.FieldByName('ID').AsInteger;
  FProductDesc := FProductDataSet.FieldByName('DESCRIPTION').AsString;
  FProductName := FProductDataSet.FieldByName('NAME').AsString;

  tbcMain.ActiveTab := tbQuestions;
end;

procedure TmCoolnection.pnlCancelClick(Sender: TObject);
begin
  tbcMain.ActiveTab := tbQuestions;
end;

procedure TmCoolnection.pnlCreateQuestionClick(Sender: TObject);
begin
  tbcMain.ActiveTab := tbCreateQuestion;
end;

procedure TmCoolnection.tbcMainChange(Sender: TObject);
begin
  ConfigurePages;
end;

procedure TmCoolnection.ChangeMemoColor(Memo: TMemo);
var Obj: TFmxObject;
    Rectangle1: TRectangle;
begin
     Obj := Memo.FindStyleResource('background');
     if Obj <> nil then
     begin
          TControl(Obj).Margins   := TBounds.Create(TRectF.Create(-2, -2, -2, -2));
          Rectangle1              := TRectangle.Create(Obj);
          Obj.AddObject(Rectangle1);
          Rectangle1.Align        := TAlignLayout.Client;
          Rectangle1.Fill.Color   := claYellow;
          Rectangle1.Stroke.Color := claNull;
          Rectangle1.HitTest      := False;
          Rectangle1.SendToBack;
     end;
end;


end.
