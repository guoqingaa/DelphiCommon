unit MD4;

interface

type
  _MD4_CTX = packed record
    state : array[0..3] of Cardinal;   ///* state ( ABCD ) */
    count : array[0..3] of Cardinal;   ///* number of bits, modulo 2^64 ( lsb first ) */
    buffer : array[0..63] of Byte;     ///* input buffer */
  end;
  TMD4_CTX = _MD4_CTX;
  PMD4_CTX = ^_MD4_CTX;

procedure MD4Init(pContext : PMD4_CTX);
procedure MD4Update(pContext : PMD4_CTX; pInput : PByte; uiLen : Cardinal);
procedure MD4Final (aDigest : array of Byte; pContext : PMD4_CTX); //[0..15]

procedure MD4Transform(state : array of Cardinal; block : array of Byte);

procedure MDEncode ( pDest : PByte; pSrc : PCardinal; uiLen : Cardinal);
procedure MDDecode ( pDest : PCardinal; pSrc : PByte; uiLen : Cardinal);

procedure MD4_memcpy(pDest : Pointer; pSrc : Pointer; uiLen : Cardinal);
procedure MD4_memset(pDest : Pointer; iValue : Integer; uiLen : Cardinal);

implementation

const
  S11 = 3;
  S12 = 7;
  S13 = 11;
  S14 = 19;
  S21 = 3;
  S22 = 5;
  S23 = 9;
  S24 = 13;
  S31 = 3;
  S32 = 9;
  S33 = 11;
  S34 = 15;

var
  PADDING : array[0..63] of byte = (
  $80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

procedure MD4Init(pContext : PMD4_CTX);
begin
  pContext^.count[0] := 0;
  pContext^.count[1] := 0;

  pContext^.state[0] := $67452301;
  pContext^.state[1] := $efcdab89;
  pContext^.state[2] := $98badcfe;
  pContext^.state[3] := $10325476;
end;

// MD4 block update operation. Continues an MD4 message-digest
// operation, processing another message block, and updating the
// context.
procedure MD4Update(pContext : PMD4_CTX; pInput : PByte; uiLen : Cardinal);
var
  ui, uiIdx, uiPartLen : Cardinal;
begin
  uiIdx := Cardinal(( pContext^.count[0] shr 3 ) and $3F) ;

  // Update number of bits */
  pContext.count[0] := pContext.count[0] + Cardinal(uiLen shl 3);
  if ( pContext.count[0] < Cardinal(uiLen shl 3) ) then
     Inc(pContext.count[1]);

  pContext.count[1] := pContext.count[1] + Cardinal(uiLen shr 29);

  uiPartLen := 64 - uiIdx ;

  // Transform as many times as possible.
  if ( uiLen >= uiPartLen ) then
  begin
    MD4_memcpy(@pContext^.buffer[uiIdx], pInput, uiPartLen) ;
    MD4Transform(pContext^.state, pContext^.buffer);

    ui := uiPartLen;
    while ( ui + 63 < uiLen ) do
    begin
      MD4Transform(pContext^.state, @pInput[ui]) ;
      ui := ui + 64;
    end;

    uiIdx := 0 ;
  end
  else
     ui := 0 ;

  // Buffer remaining input
  MD4_memcpy(@pContext^.buffer[uiIdx], pInput, uiPartLen - ui ) ;
end;

// MD4 finalization. Ends an MD4 message-digest operation, writing the
// the message digest and zeroizing the context.

procedure MD4Final(aDigest : array of Byte; pContext : PMD4_CTX);
var
  bits : array[0..7] of byte;
  uiIdx, uiPadLen : Cardinal;
begin
  // Save number of bits
  MDEncode ( bits, pContext^.count, 8 ) ;

  // Pad out to 56 mod 64.
  uiIdx := Cardinal(( pContext^.count[0] shr 3 ) and $3f ) ;
  if uiIdx < 56 then
     uiPadLen := 56 - uiIdx
  else
     uiPadLen := 120 - uiIdx ;

  MD4Update ( pContext, PADDING, uiPadLen ) ;

  // Append length ( before padding )
  MD4Update ( pContext, bits, 8 ) ;

  // Store state in digest
  MDEncode ( aDigest, pContext^.state, 16 ) ;

  // Zeroize sensitive information.
  MD4_memset(@pContext, 0, sizeof(pContext));
end;

function F(x, y, z : Cardinal) : Cardinal;
begin
  Result := ((x and y) or ((not x) and z));
end;

function G(x, y, z : Cardinal) : Cardinal;
begin
  Result := ((x and y) or (x and z) or (y and z));
end;

function H(x, y, z : Cardinal) : Cardinal;
begin
  Result := (x xor y xor z);
end;

// ROTATE_LEFT rotates x left n bits.
function ROTATE_LEFT(x, n : Cardinal) : Cardinal;
begin
  Result := ((x shl n) or (x shr (32-n)));
end;

procedure FF(var a : Cardinal; var b : Cardinal; var c : Cardinal; var d : Cardinal;
             var x : Cardinal; s : Cardinal);
begin
  a := a + F(b, c, d) + x;
  a := ROTATE_LEFT(a, s) ;
end;

procedure GG(var a : Cardinal; var b : Cardinal; var c : Cardinal; var d : Cardinal;
             var x : Cardinal; s : Cardinal);
begin
  a := a + G (b, c, d) + x + $5a827999;
  a := ROTATE_LEFT(a, s);
end;

procedure HH(var a : Cardinal; var b : Cardinal; var c : Cardinal; var d : Cardinal;
             var x : Cardinal; s : Cardinal);
begin
  a := a + H (b, c, d) + x + $6ed9eba1;
  a := ROTATE_LEFT(a, s);
end;

//static void MD4Transform ( UINT4 state [ 4 ], unsigned char block [ 64 ] )
procedure MD4Transform(state : array of Cardinal; block : array of Byte);
var
  a, b, c, d : Cardinal;
  x : array[0..15] of Cardinal;
begin
  a := state[0];
  b := state[1];
  c := state[2];
  d := state[3];

  MDDecode ( x, block, 64 ) ;

  // Round 1
  FF ( a, b, c, d, x [  0 ], S11 ) ; // 1
  FF ( d, a, b, c, x [  1 ], S12 ) ; // 2
  FF ( c, d, a, b, x [  2 ], S13 ) ; // 3
  FF ( b, c, d, a, x [  3 ], S14 ) ; // 4
  FF ( a, b, c, d, x [  4 ], S11 ) ; // 5
  FF ( d, a, b, c, x [  5 ], S12 ) ; // 6
  FF ( c, d, a, b, x [  6 ], S13 ) ; // 7
  FF ( b, c, d, a, x [  7 ], S14 ) ; // 8
  FF ( a, b, c, d, x [  8 ], S11 ) ; // 9
  FF ( d, a, b, c, x [  9 ], S12 ) ; // 10
  FF ( c, d, a, b, x [ 10 ], S13 ) ; // 11
  FF ( b, c, d, a, x [ 11 ], S14 ) ; // 12
  FF ( a, b, c, d, x [ 12 ], S11 ) ; // 13
  FF ( d, a, b, c, x [ 13 ], S12 ) ; // 14
  FF ( c, d, a, b, x [ 14 ], S13 ) ; // 15
  FF ( b, c, d, a, x [ 15 ], S14 ) ; // 16

  // Round 2
  GG ( a, b, c, d, x [  0 ], S21 ) ; // 17
  GG ( d, a, b, c, x [  4 ], S22 ) ; // 18
  GG ( c, d, a, b, x [  8 ], S23 ) ; // 19
  GG ( b, c, d, a, x [ 12 ], S24 ) ; // 20
  GG ( a, b, c, d, x [  1 ], S21 ) ; // 21
  GG ( d, a, b, c, x [  5 ], S22 ) ; // 22
  GG ( c, d, a, b, x [  9 ], S23 ) ; // 23
  GG ( b, c, d, a, x [ 13 ], S24 ) ; // 24
  GG ( a, b, c, d, x [  2 ], S21 ) ; // 25
  GG ( d, a, b, c, x [  6 ], S22 ) ; // 26
  GG ( c, d, a, b, x [ 10 ], S23 ) ; // 27
  GG ( b, c, d, a, x [ 14 ], S24 ) ; // 28
  GG ( a, b, c, d, x [  3 ], S21 ) ; // 29
  GG ( d, a, b, c, x [  7 ], S22 ) ; // 30
  GG ( c, d, a, b, x [ 11 ], S23 ) ; // 31
  GG ( b, c, d, a, x [ 15 ], S24 ) ; // 32

  // Round 3
  HH ( a, b, c, d, x [  0 ], S31 ) ; // 33 
  HH ( d, a, b, c, x [  8 ], S32 ) ; // 34 
  HH ( c, d, a, b, x [  4 ], S33 ) ; // 35 
  HH ( b, c, d, a, x [ 12 ], S34 ) ; // 36 
  HH ( a, b, c, d, x [  2 ], S31 ) ; // 37 
  HH ( d, a, b, c, x [ 10 ], S32 ) ; // 38 
  HH ( c, d, a, b, x [  6 ], S33 ) ; // 39 
  HH ( b, c, d, a, x [ 14 ], S34 ) ; // 40 
  HH ( a, b, c, d, x [  1 ], S31 ) ; // 41 
  HH ( d, a, b, c, x [  9 ], S32 ) ; // 42 
  HH ( c, d, a, b, x [  5 ], S33 ) ; // 43 
  HH ( b, c, d, a, x [ 13 ], S34 ) ; // 44 
  HH ( a, b, c, d, x [  3 ], S31 ) ; // 45 
  HH ( d, a, b, c, x [ 11 ], S32 ) ; // 46 
  HH ( c, d, a, b, x [  7 ], S33 ) ; // 47 
  HH ( b, c, d, a, x [ 15 ], S34 ) ; // 48

  state[0] := state[0] + a;
  state[1] := state[1] + b;
  state[2] := state[2] + c;
  state[3] := state[3] + d;

  // Zeroize sensitive information.
  MD4_memset(@x, 0, sizeof(x));
end;

// Encodes input ( UINT4 ) into output ( unsigned char ) . Assumes len is a multiple of 4.
procedure MDEncode ( pDest : PByte; pSrc : PCardinal; uiLen : Cardinal);
var
  i, j : Cardinal;
begin
  i := 0;
  j := 0;
  while (j < uiLen) do
  begin
    pDest[j]   := Byte(pSrc[i] and $ff);
    pDest[j+1] := Byte((pSrc[i] shr 8 ) and $ff);
    pDest[j+2] := Byte((pSrc[i] shr 16) and $ff);
    pDest[j+3] := Byte((pSrc[i] shr 24) and $ff);

    Inc(i);
    Inc(j, 4);
  end;
end;

// Decodes input ( unsigned char ) into output ( UINT4 ) . Assumes len is a multiple of 4.
procedure MDDecode ( pDest : PCardinal; pSrc : PByte; uiLen : Cardinal);
var
  i, j : Cardinal;
begin
  i := 0;
  j := 0;
  while (j < uiLen) do
  begin
    pDest[i] :=  Cardinal(pSrc[j]) or
                (Cardinal(pSrc[j+1]) shl 8) or
                (Cardinal(pSrc[j+2]) shl 16) or
                (Cardinal(pSrc[j+3]) shl 24);

    Inc(i);
    Inc(j, 4);
  end;
end;

// Note: Replace "for loop" with standard memcpy if possible.
procedure MD4_memcpy( pDest : Pointer; pSrc : Pointer; uiLen : Cardinal);
var
  i : Cardinal;
begin
  for i := 0 to uiLen - 1 do
     pDest[i] := pSrc[i];
end;

// Note: Replace "for loop" with standard memset if possible.
procedure MD4_memset(pDest : Pointer; iValue : Integer; uiLen : Cardinal);
var
  i : Cardinal;
begin
  for i := 0 to uiLen - 1 do
     PChar(pDest)[i] := Char(iValue);
end;

end.
