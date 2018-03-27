unit LUX.Asset.VisToolkit;

interface //#################################################################### ■

uses System.Generics.Collections,
     LUX, LUX.D1, LUX.D2, LUX.D3;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TElemTypes = (
          VTK_VERTEX         = 01,
          VTK_POLY_VERTEX    = 02,
          VTK_LINE           = 03,
          VTK_POLY_LINE      = 04,
          VTK_TRIANGLE       = 05,
          VTK_TRIANGLE_STRIP = 06,
          VTK_POLYGON        = 07,
          VTK_PIXEL          = 08,
          VTK_QUAD           = 09,
          VTK_TETRA          = 10,
          VTK_VOXEL          = 11,
          VTK_HEXAHEDRON     = 12,
          VTK_WEDGE          = 13,
          VTK_PYRAMID        = 14 );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkElem

     TvtkElem = class
     private
     protected
       _ID :Integer;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property ID :Integer read _ID;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkPoin

     TvtkPoin = class( TvtkElem )
     private
     protected
       _Pos :TSingle3D;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Pos :TSingle3D read _Pos write _Pos;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell

     TvtkCell = class( TvtkElem )
     private
     protected
       _Kind  :TElemTypes;
       _Poins :TArray<TvtkPoin>;
       ///// アクセス
       function GetPoins( const I_:Integer ) :TvtkPoin;
       procedure SetPoins( const I_:Integer; const Poin_:TvtkPoin );
     public
       constructor Create( const PoinsN_:Integer );
       destructor Destroy; override;
       ///// プロパティ
       property Kind                      :TElemTypes read   _Kind  write   _Kind ;
       property Poins[ const I_:Integer ] :TvtkPoin   read GetPoins write SetPoins;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell01

     TvtkCell01 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell05

     TvtkCell05 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell09

     TvtkCell09 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell10

     TvtkCell10 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell12

     TvtkCell12 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell13

     TvtkCell13 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell14

     TvtkCell14 = class( TvtkCell )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkElem

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkElem.Create;
begin
     inherited;

end;

destructor TvtkElem.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkPoin

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkPoin.Create;
begin
     inherited;

end;

destructor TvtkPoin.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

function TvtkCell.GetPoins( const I_:Integer ) :TvtkPoin;
begin
     Result := _Poins[ I_ ];
end;

procedure TvtkCell.SetPoins( const I_:Integer; const Poin_:TvtkPoin );
begin
     _Poins[ I_ ] := Poin_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell.Create( const PoinsN_:Integer );
begin
     inherited Create;

     SetLength( _Poins, PoinsN_ );
end;

destructor TvtkCell.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell01

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell01.Create;
begin
     inherited Create( 1 );

end;

destructor TvtkCell01.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell05

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell05.Create;
begin
     inherited Create( 3 );

end;

destructor TvtkCell05.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell09

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell09.Create;
begin
     inherited Create( 4 );

end;

destructor TvtkCell09.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell10

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell10.Create;
begin
     inherited Create( 4 );

end;

destructor TvtkCell10.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell12

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell12.Create;
begin
     inherited Create( 8 );

end;

destructor TvtkCell12.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell13

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell13.Create;
begin
     inherited Create( 6 );

end;

destructor TvtkCell13.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell14

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TvtkCell14.Create;
begin
     inherited Create( 5 );

end;

destructor TvtkCell14.Destroy;
begin

     inherited;
end;

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
                    _ID := _Poins.Count;

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
                    _ID := _Cells.Count;

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
