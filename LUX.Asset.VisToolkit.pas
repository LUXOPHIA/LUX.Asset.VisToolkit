unit LUX.Asset.VisToolkit;

interface //#################################################################### ■

uses System.Generics.Collections,
     LUX, LUX.D1, LUX.D2, LUX.D3,
     LUX.Asset.VisToolkit.Poin,
     LUX.Asset.VisToolkit.Cells,
     LUX.Asset.VisToolkit.Cells.LINEAR,
     LUX.Asset.VisToolkit.Cells.QUADRATIC,
     LUX.Asset.VisToolkit.Cells.CUBIC,
     LUX.Asset.VisToolkit.Cells.CONVEX,
     LUX.Asset.VisToolkit.Cells.POLYHEDRON,
     LUX.Asset.VisToolkit.Cells.PARAMETRIC,
     LUX.Asset.VisToolkit.Cells.HIGHER,
     LUX.Asset.VisToolkit.Cells.LAGRANGE;

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

uses System.SysUtils, System.Classes;

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
   S :TStreamReader;
//······································
     function ReadLineWords :TArray<String>;
     begin
          while not S.EndOfStream do
          begin
               Result := S.ReadLine.Split( [ ' ' ] );

               if Assigned( Result ) then Exit;
          end;
     end;
     //·································
     function ReadWords( const N_:Integer ) :TArray<String>;
     begin
          Result := [];

          while Length( Result ) < N_ do Result := Result + ReadLineWords;
     end;
     //·································
     procedure ReadHeader;
     var
        Ws :TArray<String>;
     begin
          Ws := ReadLineWords;

          Assert( Ws[ 0 ] = '#'       , 'ReadHeader.#[ 0 ] = ' + Ws[ 0 ] );
          Assert( Ws[ 1 ] = 'vtk'     , 'ReadHeader.#[ 1 ] = ' + Ws[ 1 ] );
          Assert( Ws[ 2 ] = 'DataFile', 'ReadHeader.#[ 2 ] = ' + Ws[ 2 ] );
          Assert( Ws[ 3 ] = 'Version' , 'ReadHeader.#[ 3 ] = ' + Ws[ 3 ] );

          _Version := Ws[ 4 ];

          _Caption := ReadLineWords[ 0 ];

          _FileType := ReadLineWords[ 0 ];

          Assert( _FileType = 'ASCII', 'ReadHeader._FileType = ' + _FileType );

          Ws := ReadLineWords;

          Assert( Ws[ 0 ] = 'DATASET', 'ReadHeader.DATASET[ 0 ] = ' + Ws[ 0 ] );

          _DataType := Ws[ 1 ];

          Assert( _DataType = 'UNSTRUCTURED_GRID', 'ReadHeader._DataType = ' + _DataType );
     end;
     //·································
     function ReadPoinPosis( const Ws_:TArray<String> ) :TArray<TSingle3D>;
     var
        PsN, N, J :Integer;
        PsT :String;
        Vs :TArray<String>;
        P :TSingle3D;
     begin
          PsN := Ws_[ 1 ].ToInteger;
          PsT := Ws_[ 2 ];

          Assert( PsT = 'float', 'ReadPoinPosis.PsT = ' + PsT );

          Vs := ReadWords( 3 * PsN );

          J := 0;
          for N := 1 to PsN do
          begin
               P.X := Vs[ J ].ToSingle;  Inc( J );
               P.Y := Vs[ J ].ToSingle;  Inc( J );
               P.Z := Vs[ J ].ToSingle;  Inc( J );

               Result := Result + [ P ];
          end;
     end;
     //·································
     function ReadCellPoins( const Ws_:TArray<String> ) :TArray2<Integer>;
     var
        CsN, I, VsN, J, PsN, K :Integer;
        Vs :TArray<String>;
        Ps :TArray<Integer>;
     begin
          CsN := Ws_[ 1 ].ToInteger;
          VsN := Ws_[ 2 ].ToInteger;

          Vs := ReadWords( VsN );

          J := 0;
          for I := 0 to CsN-1 do
          begin
               PsN := Vs[ J ].ToInteger;  Inc( J );

               Ps := [];
               for K := 0 to PsN-1 do
               begin
                    Ps := Ps + [ Vs[ J ].ToInteger ];  Inc( J );
               end;

               Result := Result + [ Ps ];
          end;
     end;
     //·································
     function ReadCellTypes( const Ws_:TArray<String> ) :TArray<TCellTypes>;
     var
        CsN, I :Integer;
        Vs :TArray<String>;
     begin
          CsN := Ws_[ 1 ].ToInteger;

          Vs := ReadWords( CsN );

          for I := 0 to CsN-1 do Result := Result + [ TCellTypes( Vs[ I ].ToInteger ) ];
     end;
     //·································
     function ReadCellDatas( const Ws_:TArray<String> ) :TArray<Single>;
     var
        CsN, I :Integer;
        Ws :TArray<String>;
     begin
          CsN := Ws_[ 1 ].ToInteger;

          Ws := ReadLineWords;

          Assert( Ws[ 0 ] = 'SCALARS', 'ReadCellDatas.SCALARS[ 0 ] = ' + Ws[ 0 ] );
          Assert( Ws[ 2 ] = 'float'  , 'ReadCellDatas.SCALARS[ 2 ] = ' + Ws[ 2 ] );

          Ws := ReadLineWords;

          Assert( Ws[ 0 ] = 'LOOKUP_TABLE', 'ReadCellDatas.LOOKUP_TABLE[ 0 ] = ' + Ws[ 0 ] );

          Ws := ReadWords( CsN );

          for I := 0 to CsN-1 do Result := Result + [ Ws[ I ].ToSingle ];
     end;
//······································
var
   L :String;
   Ws :TArray<String>;
   I, K :Integer;
   PPs :TArray<TSingle3D>;
   CPs :TArray2<Integer>;
   CTs :TArray<TCellTypes>;
   CDs :TArray<Single>;
   Poin :TvtkPoin;
   Cell :TvtkCell;
begin
     S := TStreamReader.Create( FileName_ );
     try
        ReadHeader;

        while not S.EndOfStream do
        begin
             L := S.ReadLine;  if L = '' then Continue;

             Ws := L.Split( [ ' ' ] );

             if Ws[ 0 ] = 'POINTS'     then PPs := ReadPoinPosis( Ws )
                                       else
             if Ws[ 0 ] = 'CELLS'      then CPs := ReadCellPoins( Ws )
                                       else
             if Ws[ 0 ] = 'CELL_TYPES' then CTs := ReadCellTypes( Ws )
                                       else
             if Ws[ 0 ] = 'CELL_DATA'  then CDs := ReadCellDatas( Ws );
        end;

     finally
            S.DisposeOf;
     end;

     _Poins.Clear;
     for I := 0 to High( PPs ) do
     begin
          Poin := TvtkPoin.Create;

          with Poin do
          begin
               ID := I;

               Pos := PPs[ I ];
          end;

          _Poins.Add( Poin );
     end;

     _Cells.Clear;
     for I := 0 to High( CPs ) do
     begin
          Cell := TvtkCell.New( CTs[ I ] );

          with Cell do
          begin
               ID := I;

               PoinsN := Length( CPs[ I ] );

               Scalar := CDs[ I ];

               for K := 0 to PoinsN-1 do Poins[ K ] := _Poins[ CPs[ I, K ] ];
          end;

          _Cells.Add( Cell );
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
