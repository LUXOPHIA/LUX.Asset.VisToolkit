unit LUX.Asset.VisToolkit.Model;

interface //#################################################################### ■

uses System.Generics.Collections,
     LUX, LUX.D1, LUX.D2, LUX.D3,
     LUX.Asset.VisToolkit,
     LUX.Asset.VisToolkit.Elems;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TVisToolkit

     TVisToolkit = class
     private
     protected
       _Version  :String;
       _Caption  :String;
       _FileType :String;
       _DataType :String;
       _Poins    :TObjectList<TvtkPoin>;
       _Cells    :TObjectList<TvtkCell>;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Version  :String                read _Version ;
       property Caption  :String                read _Caption ;
       property FileType :String                read _FileType;
       property DataType :String                read _DataType;
       property Poins    :TObjectList<TvtkPoin> read _Poins   ;
       property Cells    :TObjectList<TvtkCell> read _Cells   ;
       ///// メソッド
       procedure LoadFromFile( const FileName_:String );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils, System.Classes, System.RegularExpressions;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TVisToolkit

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TVisToolkit.Create;
begin
     inherited;

     _Poins := TObjectList<TvtkPoin>.Create;
     _Cells := TObjectList<TvtkCell>.Create;
end;

destructor TVisToolkit.Destroy;
begin
     _Poins.DisposeOf;
     _Cells.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TVisToolkit.LoadFromFile( const FileName_:String );
var
   F :TStreamReader;
   Vs :TArray<String>;
//······································
     function GetLine :String;
     begin
          while not F.EndOfStream do
          begin
               Result := F.ReadLine;

               if Result <> '' then Break;
          end;
     end;
     //·································
     procedure ReadValues( const VsN_:Integer );
     begin
          Vs := [];

          while Length( Vs ) < VsN_ do Vs := Vs + GetLine.Split( [ ' ' ] );
     end;
//······································
var
   R :TRegEx;
   PsN, I, CsN, VsN, EsN, J, N :Integer;
   PsT :String;
   P :TSingle3D;
   Poin :TvtkPoin;
   Cell :TvtkCell;
begin
     F := TStreamReader.Create( FileName_, TEncoding.Default );
     try
          //////////

          R := TRegEx.Create( '# +vtk +DataFile +Version +([^.]+\.[^.]+)' );

          with R.Match( GetLine ) do
          begin
               Assert( Success, '# vtk DataFile Version' );

               _Version := Groups[ 1 ].Value;
          end;

          //////////

          _Caption := GetLine;

          //////////

          _FileType := GetLine;  Assert( _FileType = 'ASCII', '_FileType = ' + _FileType );

          //////////

          R := TRegEx.Create( 'DATASET +([^ ]+)' );

          with R.Match( GetLine ) do
          begin
               Assert( Success, 'DATASET' );

               _DataType := Groups[ 1 ].Value;
          end;

          Assert( _DataType = 'UNSTRUCTURED_GRID', '_DataType = ' + _DataType );

          //////////

          R := TRegEx.Create( 'POINTS +([^ ]+) +([^ ]+)' );

          with R.Match( GetLine ) do
          begin
               Assert( Success, 'POINTS' );

               PsN := Groups[ 1 ].Value.ToInteger;
               PsT := Groups[ 2 ].Value;
          end;

          ReadValues( 3 * PsN );

          _Poins.Clear;

          I := 0;

          for N := 1 to PsN do
          begin
               Poin := TvtkPoin.Create;

               P.X := Vs[ I ].ToSingle;  Inc( I );
               P.Y := Vs[ I ].ToSingle;  Inc( I );
               P.Z := Vs[ I ].ToSingle;  Inc( I );

               with Poin do
               begin
                    ID := _Poins.Count;

                    Pos := P;
               end;

               _Poins.Add( Poin );
          end;

          //////////

          R := TRegEx.Create( 'CELLS +([^ ]+) +([^ ]+)' );

          with R.Match( GetLine ) do
          begin
               Assert( Success, 'CELLS' );

               CsN := Groups[ 1 ].Value.ToInteger;
               VsN := Groups[ 2 ].Value.ToInteger;
          end;

          ReadValues( VsN );

          _Cells.Clear;

          I := 0;

          for N := 1 to CsN do
          begin
               PsN := Vs[ I ].ToInteger;  Inc( I );

               Cell := TvtkCell.Create( PsN );

               with Cell do
               begin
                    ID := _Cells.Count;

                    for J := 0 to PsN-1 do
                    begin
                         Poins[ J ] := Self._Poins[ Vs[ I ].ToInteger ];  Inc( I );
                    end;
               end;

               _Cells.Add( Cell );
          end;

          //////////

          R := TRegEx.Create( 'CELL_TYPES +([^ ]+)' );

          with R.Match( GetLine ) do
          begin
               Assert( Success, 'CELL_TYPES' );

               CsN := Groups[ 1 ].Value.ToInteger;
          end;

          ReadValues( CsN );

          for I := 0 to CsN-1 do _Cells[ I ].Kind := TElemTypes( Vs[ I ].ToInteger );

          //////////

          //////////

          //////////


     finally
            F.DisposeOf;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
