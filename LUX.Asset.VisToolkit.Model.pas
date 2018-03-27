unit LUX.Asset.VisToolkit.Model;

interface //#################################################################### ■

uses System.Generics.Collections, System.RegularExpressions,
     LUX, LUX.D1, LUX.D2, LUX.D3,
     LUX.Asset.VisToolkit,
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
       function ReadPOINTS2( const M_:TMatch ) :TArray<TSingle3D>;
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

function TVisToolkit.ReadPOINTS2( const M_:TMatch ) :TArray<TSingle3D>;
var
   PsN, N, J :Integer;
   PsT :String;
   Vs :TArray<String>;
   P :TSingle3D;
begin
     with M_ do
     begin
          PsN := Groups[ 1 ].Value.ToInteger;
          PsT := Groups[ 2 ].Value;
     end;

     Assert( PsT = 'float', 'PsT = ' + PsT );

     //Vs := ReadValues( 3 * PsN );

     J := 0;
     for N := 1 to PsN do
     begin
          P.X := Vs[ J ].ToSingle;  Inc( J );
          P.Y := Vs[ J ].ToSingle;  Inc( J );
          P.Z := Vs[ J ].ToSingle;  Inc( J );

          Result := Result + [ P ];
     end;
end;

procedure TVisToolkit.LoadFromFile( const FileName_:String );
var
   REs :TArray<TRegEx>;
   S :TStreamReader;
//······································
     function ReadLine :String;
     begin
          while not S.EndOfStream do
          begin
               Result := S.ReadLine;

               if Result <> '' then Break;
          end;
     end;
     //·································
     function ReadValues( const N_:Integer ) :TArray<String>;
     begin
          Result := [];

          while Length( Result ) < N_ do Result := Result + ReadLine.Split( [ ' ' ] );
     end;
     //·································
     procedure ReadHeader;
     begin
          with TRegEx.Create( '# +vtk +DataFile +Version +([^.]+\.[^.]+)' ).Match( ReadLine ) do
          begin
               Assert( Success, '# vtk DataFile Version' );

               _Version := Groups[ 1 ].Value;
          end;

          _Caption := ReadLine;

          _FileType := ReadLine;  Assert( _FileType = 'ASCII', '_FileType = ' + _FileType );

          with TRegEx.Create( 'DATASET +([^ ]+)' ).Match( ReadLine ) do
          begin
               Assert( Success, 'DATASET' );

               _DataType := Groups[ 1 ].Value;
          end;

          Assert( _DataType = 'UNSTRUCTURED_GRID', '_DataType = ' + _DataType );
     end;
     //·································
     function ReadPoins( const M_:TMatch ) :TArray<TSingle3D>;
     var
        PsN, N, J :Integer;
        PsT :String;
        Vs :TArray<String>;
        P :TSingle3D;
     begin
          with M_ do
          begin
               PsN := Groups[ 1 ].Value.ToInteger;
               PsT := Groups[ 2 ].Value;
          end;

          Assert( PsT = 'float', 'PsT = ' + PsT );

          Vs := ReadValues( 3 * PsN );

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
     function ReadCells( const M_:TMatch ) :TArray2<Integer>;
     var
        CsN, I, VsN, J, PsN, K :Integer;
        Vs :TArray<String>;
        Ps :TArray<Integer>;
     begin
          with M_ do
          begin
               CsN := Groups[ 1 ].Value.ToInteger;
               VsN := Groups[ 2 ].Value.ToInteger;
          end;

          Vs := ReadValues( VsN );

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
     function ReadTypes( const M_:TMatch ) :TArray<TCellTypes>;
     var
        CsN, I :Integer;
        Vs :TArray<String>;
     begin
          with M_ do CsN := Groups[ 1 ].Value.ToInteger;

          Vs := ReadValues( CsN );

          for I := 0 to CsN-1 do Result := Result + [ TCellTypes( Vs[ I ].ToInteger ) ];
     end;
//······································
var
   L :String;
   I, K :Integer;
   M :TMatch;
   Ps :TArray<TSingle3D>;
   Cs :TArray2<Integer>;
   Ts :TArray<TCellTypes>;
   Poin :TvtkPoin;
   Cell :TvtkCell;
begin
     REs := [ TRegEx.Create( 'POINTS +([^ ]+) +([^ ]+)', [ TRegExOption.roCompiled ] ),
              TRegEx.Create( 'CELLS +([^ ]+) +([^ ]+)' , [ TRegExOption.roCompiled ] ),
              TRegEx.Create( 'CELL_TYPES +([^ ]+)'     , [ TRegExOption.roCompiled ] ) ];

     S := TStreamReader.Create( FileName_ );
     try
        ReadHeader;

        while not S.EndOfStream do
        begin
             L := S.ReadLine;  if L = '' then Continue;

             for I := 0 to High( REs ) do
             begin
                  M := REs[ I ].Match( L );

                  if M.Success then
                  begin
                       case I of
                         0:Ps := ReadPoins( M );
                         1:Cs := ReadCells( M );
                         2:Ts := ReadTypes( M );
                       end;
                  end;
             end;
        end;

     finally
            S.DisposeOf;
     end;

     _Poins.Clear;
     for I := 0 to High( Ps ) do
     begin
          Poin := TvtkPoin.Create;

          with Poin do
          begin
               ID := I;

               Pos := Ps[ I ];
          end;

          _Poins.Add( Poin );
     end;

     _Cells.Clear;
     for I := 0 to High( Ts ) do
     begin
          Cell := TvtkCell.New( Ts[ I ] );

          with Cell do
          begin
               ID := I;

               PoinsN := Length( Cs[ I ] );

               for K := 0 to PoinsN-1 do Poins[ K ] := _Poins[ Cs[ I, K ] ];
          end;

          _Cells.Add( Cell );
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
