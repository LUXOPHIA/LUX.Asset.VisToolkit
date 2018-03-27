unit LUX.Asset.VisToolkit.Elems;

interface //#################################################################### ■

uses LUX, LUX.D1, LUX.D2, LUX.D3,
     LUX.Asset.VisToolkit;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TElemTypes = (
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
       VTK_NUMBER_OF_CELL_TYPES                   );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils, System.Classes, System.RegularExpressions;

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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
