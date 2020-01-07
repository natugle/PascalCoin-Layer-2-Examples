unit Unit1;

{$mode objfpc}{$H+}

{*
* PascalCoin Layer-2 Example
* Copyright (c) 2020 by Preben Bjorn Biermann Madsen
* Distributed under the MIT software license
*
* This is a very simple example to show how to
* send or receive data in the Pascal network
* using JSON-RPC calls to the build in server.
*
* All operations are saved in the blockchain
*
* See PIP-0033: DATA operation RPC implementation
* https://www.pascalcoin.org/development/pips/pip-0033
*
* See also JSON RPC API Specification & Guideline
* https://github.com/PascalCoinDev/PascalCoin/wiki/JSON-RPC-API
*}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fphttpclient; // <--- Add this native http client to uses

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// method: senddata
// send call to Pascal JSON-RPC Server using HTTP Post
// params: sender: account #, target: account #, payload: hex string
// See PIP-0033 for all possible params and more info
// run Pascal Wallet or Daemon with RPC server enabled
// set port to 4003(mainnet) or 4103 or 4203 (testnet)
// set sender to an account you own

procedure TForm1.Button1Click(Sender: TObject);
var
  client: TFPHTTPClient;
  respons: String;
begin
  client := TFPHTTPClient.Create(nil);
  try
    try  // remember to set port, sender and target
      respons := client.SimpleFormPost('http://localhost:4003/',
                '{"jsonrpc":"2.0","method":"senddata","params":{"sender":"000000", "target":"000000", "payload":"0123456789ABCDEF"},"id":123}');
      memo1.Text := respons;
    except
      on E: exception do ShowMessage(E.Message);
    end;
  finally
    client.Free;
  end;
end;

// method: finddataoperations
// send call to Pascal JSON-RPC Server using HTTP Post
// params: target: account #
// See PIP-0030 for all possible params and more info
// the call returns by default the 100 latest operations
// run Pascal Wallet or Daemon with RPC server enabled
// set port to 4003(mainnet) or 4103 or 4203 (testnet)
// set target to an account you own

procedure TForm1.Button2Click(Sender: TObject);
var
  client: TFPHTTPClient;
  respons: String;
begin
  client := TFPHTTPClient.Create(nil);
  try
    try  // remember to set port and target
      respons := client.SimpleFormPost('http://localhost:4003/',
                '{"jsonrpc":"2.0","method":"finddataoperations","params":{"target":"000000"},"id":123}');
      memo1.Text := respons; // do something - her we just write to the memo
    except
      on E: exception do ShowMessage(E.Message);
    end;
  finally
    client.Free;
  end;
end;

end.

