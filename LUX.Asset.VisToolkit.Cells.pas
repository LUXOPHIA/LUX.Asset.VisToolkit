unit LUX.Asset.VisToolkit.Cells;

interface //#################################################################### ■

uses LUX, LUX.D1, LUX.D2, LUX.D3,
     LUX.Asset.VisToolkit_,
     LUX.Asset.VisToolkit.Poin;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCellTypes = (
       // Linear cells
       VTK_EMPTY_CELL                       = 00,
       VTK_VERTEX                           = 01,
       VTK_POLY_VERTEX                      = 02,
       VTK_LINE                             = 03,
       VTK_POLY_LINE                        = 04,
       VTK_TRIANGLE                         = 05,
       VTK_TRIANGLE_STRIP                   = 06,
       VTK_POLYGON                          = 07,
       VTK_PIXEL                            = 08,
       VTK_QUAD                             = 09,
       VTK_TETRA                            = 10,
       VTK_VOXEL                            = 11,
       VTK_HEXAHEDRON                       = 12,
       VTK_WEDGE                            = 13,
       VTK_PYRAMID                          = 14,
       VTK_PENTAGONAL_PRISM                 = 15,
       VTK_HEXAGONAL_PRISM                  = 16,
       // Quadratic, isoparametric cells
       VTK_QUADRATIC_EDGE                   = 21,
       VTK_QUADRATIC_TRIANGLE               = 22,
       VTK_QUADRATIC_QUAD                   = 23,
       VTK_QUADRATIC_POLYGON                = 36,
       VTK_QUADRATIC_TETRA                  = 24,
       VTK_QUADRATIC_HEXAHEDRON             = 25,
       VTK_QUADRATIC_WEDGE                  = 26,
       VTK_QUADRATIC_PYRAMID                = 27,
       VTK_BIQUADRATIC_QUAD                 = 28,
       VTK_TRIQUADRATIC_HEXAHEDRON          = 29,
       VTK_QUADRATIC_LINEAR_QUAD            = 30,
       VTK_QUADRATIC_LINEAR_WEDGE           = 31,
       VTK_BIQUADRATIC_QUADRATIC_WEDGE      = 32,
       VTK_BIQUADRATIC_QUADRATIC_HEXAHEDRON = 33,
       VTK_BIQUADRATIC_TRIANGLE             = 34,
       // Cubic, isoparametric cell
       VTK_CUBIC_LINE                       = 35,
       // Special class of cells formed by convex group of points
       VTK_CONVEX_POINT_SET                 = 41,
       // Polyhedron cell (consisting of polygonal faces)
       VTK_POLYHEDRON                       = 42,
       // Higher order cells in parametric form
       VTK_PARAMETRIC_CURVE                 = 51,
       VTK_PARAMETRIC_SURFACE               = 52,
       VTK_PARAMETRIC_TRI_SURFACE           = 53,
       VTK_PARAMETRIC_QUAD_SURFACE          = 54,
       VTK_PARAMETRIC_TETRA_REGION          = 55,
       VTK_PARAMETRIC_HEX_REGION            = 56,
       // Higher order cells
       VTK_HIGHER_ORDER_EDGE                = 60,
       VTK_HIGHER_ORDER_TRIANGLE            = 61,
       VTK_HIGHER_ORDER_QUAD                = 62,
       VTK_HIGHER_ORDER_POLYGON             = 63,
       VTK_HIGHER_ORDER_TETRAHEDRON         = 64,
       VTK_HIGHER_ORDER_WEDGE               = 65,
       VTK_HIGHER_ORDER_PYRAMID             = 66,
       VTK_HIGHER_ORDER_HEXAHEDRON          = 67,
       // Arbitrary order Lagrange elements (formulated separated from generic higher order cells)
       VTK_LAGRANGE_CURVE                   = 68,
       VTK_LAGRANGE_TRIANGLE                = 69,
       VTK_LAGRANGE_QUADRILATERAL           = 70,
       VTK_LAGRANGE_TETRAHEDRON             = 71,
       VTK_LAGRANGE_HEXAHEDRON              = 72,
       VTK_LAGRANGE_WEDGE                   = 73,
       VTK_LAGRANGE_PYRAMID                 = 74,
       VTK_NUMBER_OF_CELL_TYPES                  );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TvtkCell

     TvtkCell = class( TvtkElem )
     private
     protected
       _Kind   :TCellTypes;
       _Poins  :TArray<TvtkPoin>;
       _Scalar :Single;
       _Vector :TSingle3D;
       ///// アクセス
       function GetPoins( const I_:Integer ) :TvtkPoin;
       procedure SetPoins( const I_:Integer; const Poin_:TvtkPoin );
       function GetPoinsN :Integer;
       procedure SetPoinsN( const PoinsN_:Integer );
     public
       class function New( const Kind_:TCellTypes ) :TvtkCell;
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Kind                      :TCellTypes read   _Kind   write   _Kind  ;
       property Poins[ const I_:Integer ] :TvtkPoin   read GetPoins  write SetPoins ;
       property PoinsN                    :Integer    read GetPoinsN write SetPoinsN;
       property Scalar                    :Single     read   _Scalar write   _Scalar;
       property Vector                    :TSingle3D  read   _Vector write   _Vector;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.Asset.VisToolkit.Cells.LINEAR,
     LUX.Asset.VisToolkit.Cells.QUADRATIC,
     LUX.Asset.VisToolkit.Cells.CUBIC,
     LUX.Asset.VisToolkit.Cells.CONVEX,
     LUX.Asset.VisToolkit.Cells.POLYHEDRON,
     LUX.Asset.VisToolkit.Cells.PARAMETRIC,
     LUX.Asset.VisToolkit.Cells.HIGHER,
     LUX.Asset.VisToolkit.Cells.LAGRANGE;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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

//------------------------------------------------------------------------------

function TvtkCell.GetPoinsN :Integer;
begin
     Result := Length( _Poins );
end;

procedure TvtkCell.SetPoinsN( const PoinsN_:Integer );
begin
     SetLength( _Poins, PoinsN_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class function TvtkCell.New( const Kind_:TCellTypes ) :TvtkCell;
begin
     inherited;

     case Integer( Kind_ ) of
      /// Linear cells
      00: Result := TvtkCell00.Create;
      01: Result := TvtkCell01.Create;
      02: Result := TvtkCell02.Create;
      03: Result := TvtkCell03.Create;
      04: Result := TvtkCell04.Create;
      05: Result := TvtkCell05.Create;
      06: Result := TvtkCell06.Create;
      07: Result := TvtkCell07.Create;
      08: Result := TvtkCell08.Create;
      09: Result := TvtkCell09.Create;
      10: Result := TvtkCell10.Create;
      11: Result := TvtkCell11.Create;
      12: Result := TvtkCell12.Create;
      13: Result := TvtkCell13.Create;
      14: Result := TvtkCell14.Create;
      15: Result := TvtkCell15.Create;
      16: Result := TvtkCell16.Create;
      /// Quadratic, isoparametric cells
      21: Result := TvtkCell21.Create;
      22: Result := TvtkCell22.Create;
      23: Result := TvtkCell23.Create;
      36: Result := TvtkCell36.Create;
      24: Result := TvtkCell24.Create;
      25: Result := TvtkCell25.Create;
      26: Result := TvtkCell26.Create;
      27: Result := TvtkCell27.Create;
      28: Result := TvtkCell28.Create;
      29: Result := TvtkCell29.Create;
      30: Result := TvtkCell30.Create;
      31: Result := TvtkCell31.Create;
      32: Result := TvtkCell32.Create;
      33: Result := TvtkCell33.Create;
      34: Result := TvtkCell34.Create;
      /// Cubic, isoparametric cell
      35: Result := TvtkCell35.Create;
      /// Special class of cells formed by convex group of points
      41: Result := TvtkCell41.Create;
      /// Polyhedron cell (consisting of polygonal faces)
      42: Result := TvtkCell42.Create;
      /// Higher order cells in parametric form
      51: Result := TvtkCell51.Create;
      52: Result := TvtkCell52.Create;
      53: Result := TvtkCell53.Create;
      54: Result := TvtkCell54.Create;
      55: Result := TvtkCell55.Create;
      56: Result := TvtkCell56.Create;
      /// Higher order cells
      60: Result := TvtkCell60.Create;
      61: Result := TvtkCell61.Create;
      62: Result := TvtkCell62.Create;
      63: Result := TvtkCell63.Create;
      64: Result := TvtkCell64.Create;
      65: Result := TvtkCell65.Create;
      66: Result := TvtkCell66.Create;
      67: Result := TvtkCell67.Create;
      /// Arbitrary order Lagrange elements (formulated separated from generic higher order cells)
      68: Result := TvtkCell68.Create;
      69: Result := TvtkCell69.Create;
      70: Result := TvtkCell70.Create;
      71: Result := TvtkCell71.Create;
      72: Result := TvtkCell72.Create;
      73: Result := TvtkCell73.Create;
      74: Result := TvtkCell74.Create;
     end;
end;

constructor TvtkCell.Create;
begin
     inherited;

end;

destructor TvtkCell.Destroy;
begin

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
