unit FormInTabs.Mobile.View.Vendas.Lista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FormInTabs.Mobile.View.FormModel, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.TabControl;

type
  TFormVendaLista = class(TFormModel)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnHeaderRightClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ListItem();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVendaLista: TFormVendaLista;

implementation

uses
  FormInTabs.Mobile.View.Vendas.Crud, FormInTabs.Lib.Utils;

{$R *.fmx}

procedure TFormVendaLista.btnHeaderRightClick(Sender: TObject);
begin
  inherited;
  OpenForm(TFormVendaCrud);
end;

procedure TFormVendaLista.Button1Click(Sender: TObject);
var
  LThread: TThread;
begin
  inherited;
  {LThread := TThread.CreateAnonymousThread( //
    procedure
    begin
      ListItem;
    end //
    );
  LThread.FreeOnTerminate := True;
  LThread.Start;}
  TUtils.ThreadCustom( //
    procedure
    begin // OnShow
      TUtils.LoadingShow(lytBackground, 'Aguarde');
    end, //
    procedure
    begin // OnProcess
      ListItem;
    end, //
    procedure
    begin // OnComplete
      TUtils.LoadignHide;
    end, //
    procedure(const AValue: string)
    begin // OnError
      TUtils.LoadignHide;
      ShowMessage(AValue);
    end, //
    False //
  );
end;

procedure TFormVendaLista.Button2Click(Sender: TObject);
begin
  inherited;
  ListItem;
end;

procedure TFormVendaLista.ListItem;
var
  i: Integer;
begin
  for i := 0 to 100 do
  begin
    Label1.Text := i.ToString;

    TUtils.LoadingChangeMessage('Aguarde ' + i.ToString);

    TThread.Synchronize( //
      TThread.CurrentThread, //
      procedure
      begin
        Label2.Text := i.ToString;
      end //
      );
    Sleep(100);
  end;
end;

end.
