{===============================================================================

    SEED Block cipher Algorithm
    Block size  : 128bit
    Key size    : 128bit
    Round       : 16

    KISA(Korea Information Security Agency : 한국정보보호진흥원)과
    Korea(대한민국)의 암호 전문가들이 모여 만든 블록 암호화 알고리즘입니다.

    KISA에서 제공하는 SEED 알고리즘은 C와 JAVA만 지원하는 관계로 직접
    Pascal 소스로 전환하였습니다.
    좀 더 많은 암호화 알고리즘들과 각 알고리즘들이 Pascal로 지원되었으면
    하는 바람으로 KISA에서 제공되는 소스를 기반으로 제작하였읍니다.

===============================================================================}
unit Seed;

interface

uses
  Windows;

type
  TArrList = Array[0..1] of LongWord;

const
  ENDIAN = true;  // Intel 80x86, DEC VAX, DEC PDP-11;
  //ENDIAN = false; // IBM370, Motorola 68000, Pyramid

const
  NoRounds = 16;
  NoRoundKeys = (NoRounds * 2);
  SeedBlockSize = 16;
  SeedBlockLen = 128;  

const
  SS0       : Array[0..255] of DWORD = (
    $2989a1a8, $05858184, $16c6d2d4, $13c3d3d0, $14445054, $1d0d111c, $2c8ca0ac, $25052124,
    $1d4d515c, $03434340, $18081018, $1e0e121c, $11415150, $3cccf0fc, $0acac2c8, $23436360,
    $28082028, $04444044, $20002020, $1d8d919c, $20c0e0e0, $22c2e2e0, $08c8c0c8, $17071314,
    $2585a1a4, $0f8f838c, $03030300, $3b4b7378, $3b8bb3b8, $13031310, $12c2d2d0, $2ecee2ec,
    $30407070, $0c8c808c, $3f0f333c, $2888a0a8, $32023230, $1dcdd1dc, $36c6f2f4, $34447074,
    $2ccce0ec, $15859194, $0b0b0308, $17475354, $1c4c505c, $1b4b5358, $3d8db1bc, $01010100,
    $24042024, $1c0c101c, $33437370, $18889098, $10001010, $0cccc0cc, $32c2f2f0, $19c9d1d8,
    $2c0c202c, $27c7e3e4, $32427270, $03838380, $1b8b9398, $11c1d1d0, $06868284, $09c9c1c8,
    $20406060, $10405050, $2383a3a0, $2bcbe3e8, $0d0d010c, $3686b2b4, $1e8e929c, $0f4f434c,
    $3787b3b4, $1a4a5258, $06c6c2c4, $38487078, $2686a2a4, $12021210, $2f8fa3ac, $15c5d1d4,
    $21416160, $03c3c3c0, $3484b0b4, $01414140, $12425250, $3d4d717c, $0d8d818c, $08080008,
    $1f0f131c, $19899198, $00000000, $19091118, $04040004, $13435350, $37c7f3f4, $21c1e1e0,
    $3dcdf1fc, $36467274, $2f0f232c, $27072324, $3080b0b0, $0b8b8388, $0e0e020c, $2b8ba3a8,
    $2282a2a0, $2e4e626c, $13839390, $0d4d414c, $29496168, $3c4c707c, $09090108, $0a0a0208,
    $3f8fb3bc, $2fcfe3ec, $33c3f3f0, $05c5c1c4, $07878384, $14041014, $3ecef2fc, $24446064,
    $1eced2dc, $2e0e222c, $0b4b4348, $1a0a1218, $06060204, $21012120, $2b4b6368, $26466264,
    $02020200, $35c5f1f4, $12829290, $0a8a8288, $0c0c000c, $3383b3b0, $3e4e727c, $10c0d0d0,
    $3a4a7278, $07474344, $16869294, $25c5e1e4, $26062224, $00808080, $2d8da1ac, $1fcfd3dc,
    $2181a1a0, $30003030, $37073334, $2e8ea2ac, $36063234, $15051114, $22022220, $38083038,
    $34c4f0f4, $2787a3a4, $05454144, $0c4c404c, $01818180, $29c9e1e8, $04848084, $17879394,
    $35053134, $0bcbc3c8, $0ecec2cc, $3c0c303c, $31417170, $11011110, $07c7c3c4, $09898188,
    $35457174, $3bcbf3f8, $1acad2d8, $38c8f0f8, $14849094, $19495158, $02828280, $04c4c0c4,
    $3fcff3fc, $09494148, $39093138, $27476364, $00c0c0c0, $0fcfc3cc, $17c7d3d4, $3888b0b8,
    $0f0f030c, $0e8e828c, $02424240, $23032320, $11819190, $2c4c606c, $1bcbd3d8, $2484a0a4,
    $34043034, $31c1f1f0, $08484048, $02c2c2c0, $2f4f636c, $3d0d313c, $2d0d212c, $00404040,
    $3e8eb2bc, $3e0e323c, $3c8cb0bc, $01c1c1c0, $2a8aa2a8, $3a8ab2b8, $0e4e424c, $15455154,
    $3b0b3338, $1cccd0dc, $28486068, $3f4f737c, $1c8c909c, $18c8d0d8, $0a4a4248, $16465254,
    $37477374, $2080a0a0, $2dcde1ec, $06464244, $3585b1b4, $2b0b2328, $25456164, $3acaf2f8,
    $23c3e3e0, $3989b1b8, $3181b1b0, $1f8f939c, $1e4e525c, $39c9f1f8, $26c6e2e4, $3282b2b0,
    $31013130, $2acae2e8, $2d4d616c, $1f4f535c, $24c4e0e4, $30c0f0f0, $0dcdc1cc, $08888088,
    $16061214, $3a0a3238, $18485058, $14c4d0d4, $22426260, $29092128, $07070304, $33033330,
    $28c8e0e8, $1b0b1318, $05050104, $39497178, $10809090, $2a4a6268, $2a0a2228, $1a8a9298
  );
  SS1       : Array[0..255] of DWORD = (
    $38380830, $e828c8e0, $2c2d0d21, $a42686a2, $cc0fcfc3, $dc1eced2, $b03383b3, $b83888b0,
    $ac2f8fa3, $60204060, $54154551, $c407c7c3, $44044440, $6c2f4f63, $682b4b63, $581b4b53,
    $c003c3c3, $60224262, $30330333, $b43585b1, $28290921, $a02080a0, $e022c2e2, $a42787a3,
    $d013c3d3, $90118191, $10110111, $04060602, $1c1c0c10, $bc3c8cb0, $34360632, $480b4b43,
    $ec2fcfe3, $88088880, $6c2c4c60, $a82888a0, $14170713, $c404c4c0, $14160612, $f434c4f0,
    $c002c2c2, $44054541, $e021c1e1, $d416c6d2, $3c3f0f33, $3c3d0d31, $8c0e8e82, $98188890,
    $28280820, $4c0e4e42, $f436c6f2, $3c3e0e32, $a42585a1, $f839c9f1, $0c0d0d01, $dc1fcfd3,
    $d818c8d0, $282b0b23, $64264662, $783a4a72, $24270723, $2c2f0f23, $f031c1f1, $70324272,
    $40024242, $d414c4d0, $40014141, $c000c0c0, $70334373, $64274763, $ac2c8ca0, $880b8b83,
    $f437c7f3, $ac2d8da1, $80008080, $1c1f0f13, $c80acac2, $2c2c0c20, $a82a8aa2, $34340430,
    $d012c2d2, $080b0b03, $ec2ecee2, $e829c9e1, $5c1d4d51, $94148490, $18180810, $f838c8f0,
    $54174753, $ac2e8ea2, $08080800, $c405c5c1, $10130313, $cc0dcdc1, $84068682, $b83989b1,
    $fc3fcff3, $7c3d4d71, $c001c1c1, $30310131, $f435c5f1, $880a8a82, $682a4a62, $b03181b1,
    $d011c1d1, $20200020, $d417c7d3, $00020202, $20220222, $04040400, $68284860, $70314171,
    $04070703, $d81bcbd3, $9c1d8d91, $98198991, $60214161, $bc3e8eb2, $e426c6e2, $58194951,
    $dc1dcdd1, $50114151, $90108090, $dc1cccd0, $981a8a92, $a02383a3, $a82b8ba3, $d010c0d0,
    $80018181, $0c0f0f03, $44074743, $181a0a12, $e023c3e3, $ec2ccce0, $8c0d8d81, $bc3f8fb3,
    $94168692, $783b4b73, $5c1c4c50, $a02282a2, $a02181a1, $60234363, $20230323, $4c0d4d41,
    $c808c8c0, $9c1e8e92, $9c1c8c90, $383a0a32, $0c0c0c00, $2c2e0e22, $b83a8ab2, $6c2e4e62,
    $9c1f8f93, $581a4a52, $f032c2f2, $90128292, $f033c3f3, $48094941, $78384870, $cc0cccc0,
    $14150511, $f83bcbf3, $70304070, $74354571, $7c3f4f73, $34350531, $10100010, $00030303,
    $64244460, $6c2d4d61, $c406c6c2, $74344470, $d415c5d1, $b43484b0, $e82acae2, $08090901,
    $74364672, $18190911, $fc3ecef2, $40004040, $10120212, $e020c0e0, $bc3d8db1, $04050501,
    $f83acaf2, $00010101, $f030c0f0, $282a0a22, $5c1e4e52, $a82989a1, $54164652, $40034343,
    $84058581, $14140410, $88098981, $981b8b93, $b03080b0, $e425c5e1, $48084840, $78394971,
    $94178793, $fc3cccf0, $1c1e0e12, $80028282, $20210121, $8c0c8c80, $181b0b13, $5c1f4f53,
    $74374773, $54144450, $b03282b2, $1c1d0d11, $24250521, $4c0f4f43, $00000000, $44064642,
    $ec2dcde1, $58184850, $50124252, $e82bcbe3, $7c3e4e72, $d81acad2, $c809c9c1, $fc3dcdf1,
    $30300030, $94158591, $64254561, $3c3c0c30, $b43686b2, $e424c4e0, $b83b8bb3, $7c3c4c70,
    $0c0e0e02, $50104050, $38390931, $24260622, $30320232, $84048480, $68294961, $90138393,
    $34370733, $e427c7e3, $24240420, $a42484a0, $c80bcbc3, $50134353, $080a0a02, $84078783,
    $d819c9d1, $4c0c4c40, $80038383, $8c0f8f83, $cc0ecec2, $383b0b33, $480a4a42, $b43787b3
  );
  SS2       : Array[0..255] of DWORD = (
    $a1a82989, $81840585, $d2d416c6, $d3d013c3, $50541444, $111c1d0d, $a0ac2c8c, $21242505,
    $515c1d4d, $43400343, $10181808, $121c1e0e, $51501141, $f0fc3ccc, $c2c80aca, $63602343,
    $20282808, $40440444, $20202000, $919c1d8d, $e0e020c0, $e2e022c2, $c0c808c8, $13141707,
    $a1a42585, $838c0f8f, $03000303, $73783b4b, $b3b83b8b, $13101303, $d2d012c2, $e2ec2ece,
    $70703040, $808c0c8c, $333c3f0f, $a0a82888, $32303202, $d1dc1dcd, $f2f436c6, $70743444,
    $e0ec2ccc, $91941585, $03080b0b, $53541747, $505c1c4c, $53581b4b, $b1bc3d8d, $01000101,
    $20242404, $101c1c0c, $73703343, $90981888, $10101000, $c0cc0ccc, $f2f032c2, $d1d819c9,
    $202c2c0c, $e3e427c7, $72703242, $83800383, $93981b8b, $d1d011c1, $82840686, $c1c809c9,
    $60602040, $50501040, $a3a02383, $e3e82bcb, $010c0d0d, $b2b43686, $929c1e8e, $434c0f4f,
    $b3b43787, $52581a4a, $c2c406c6, $70783848, $a2a42686, $12101202, $a3ac2f8f, $d1d415c5,
    $61602141, $c3c003c3, $b0b43484, $41400141, $52501242, $717c3d4d, $818c0d8d, $00080808,
    $131c1f0f, $91981989, $00000000, $11181909, $00040404, $53501343, $f3f437c7, $e1e021c1,
    $f1fc3dcd, $72743646, $232c2f0f, $23242707, $b0b03080, $83880b8b, $020c0e0e, $a3a82b8b,
    $a2a02282, $626c2e4e, $93901383, $414c0d4d, $61682949, $707c3c4c, $01080909, $02080a0a,
    $b3bc3f8f, $e3ec2fcf, $f3f033c3, $c1c405c5, $83840787, $10141404, $f2fc3ece, $60642444,
    $d2dc1ece, $222c2e0e, $43480b4b, $12181a0a, $02040606, $21202101, $63682b4b, $62642646,
    $02000202, $f1f435c5, $92901282, $82880a8a, $000c0c0c, $b3b03383, $727c3e4e, $d0d010c0,
    $72783a4a, $43440747, $92941686, $e1e425c5, $22242606, $80800080, $a1ac2d8d, $d3dc1fcf,
    $a1a02181, $30303000, $33343707, $a2ac2e8e, $32343606, $11141505, $22202202, $30383808,
    $f0f434c4, $a3a42787, $41440545, $404c0c4c, $81800181, $e1e829c9, $80840484, $93941787,
    $31343505, $c3c80bcb, $c2cc0ece, $303c3c0c, $71703141, $11101101, $c3c407c7, $81880989,
    $71743545, $f3f83bcb, $d2d81aca, $f0f838c8, $90941484, $51581949, $82800282, $c0c404c4,
    $f3fc3fcf, $41480949, $31383909, $63642747, $c0c000c0, $c3cc0fcf, $d3d417c7, $b0b83888,
    $030c0f0f, $828c0e8e, $42400242, $23202303, $91901181, $606c2c4c, $d3d81bcb, $a0a42484,
    $30343404, $f1f031c1, $40480848, $c2c002c2, $636c2f4f, $313c3d0d, $212c2d0d, $40400040,
    $b2bc3e8e, $323c3e0e, $b0bc3c8c, $c1c001c1, $a2a82a8a, $b2b83a8a, $424c0e4e, $51541545,
    $33383b0b, $d0dc1ccc, $60682848, $737c3f4f, $909c1c8c, $d0d818c8, $42480a4a, $52541646,
    $73743747, $a0a02080, $e1ec2dcd, $42440646, $b1b43585, $23282b0b, $61642545, $f2f83aca,
    $e3e023c3, $b1b83989, $b1b03181, $939c1f8f, $525c1e4e, $f1f839c9, $e2e426c6, $b2b03282,
    $31303101, $e2e82aca, $616c2d4d, $535c1f4f, $e0e424c4, $f0f030c0, $c1cc0dcd, $80880888,
    $12141606, $32383a0a, $50581848, $d0d414c4, $62602242, $21282909, $03040707, $33303303,
    $e0e828c8, $13181b0b, $01040505, $71783949, $90901080, $62682a4a, $22282a0a, $92981a8a
  );
  SS3       : Array[0..255] of DWORD = (
    $08303838, $c8e0e828, $0d212c2d, $86a2a426, $cfc3cc0f, $ced2dc1e, $83b3b033, $88b0b838,
    $8fa3ac2f, $40606020, $45515415, $c7c3c407, $44404404, $4f636c2f, $4b63682b, $4b53581b,
    $c3c3c003, $42626022, $03333033, $85b1b435, $09212829, $80a0a020, $c2e2e022, $87a3a427,
    $c3d3d013, $81919011, $01111011, $06020406, $0c101c1c, $8cb0bc3c, $06323436, $4b43480b,
    $cfe3ec2f, $88808808, $4c606c2c, $88a0a828, $07131417, $c4c0c404, $06121416, $c4f0f434,
    $c2c2c002, $45414405, $c1e1e021, $c6d2d416, $0f333c3f, $0d313c3d, $8e828c0e, $88909818,
    $08202828, $4e424c0e, $c6f2f436, $0e323c3e, $85a1a425, $c9f1f839, $0d010c0d, $cfd3dc1f,
    $c8d0d818, $0b23282b, $46626426, $4a72783a, $07232427, $0f232c2f, $c1f1f031, $42727032,
    $42424002, $c4d0d414, $41414001, $c0c0c000, $43737033, $47636427, $8ca0ac2c, $8b83880b,
    $c7f3f437, $8da1ac2d, $80808000, $0f131c1f, $cac2c80a, $0c202c2c, $8aa2a82a, $04303434,
    $c2d2d012, $0b03080b, $cee2ec2e, $c9e1e829, $4d515c1d, $84909414, $08101818, $c8f0f838,
    $47535417, $8ea2ac2e, $08000808, $c5c1c405, $03131013, $cdc1cc0d, $86828406, $89b1b839,
    $cff3fc3f, $4d717c3d, $c1c1c001, $01313031, $c5f1f435, $8a82880a, $4a62682a, $81b1b031,
    $c1d1d011, $00202020, $c7d3d417, $02020002, $02222022, $04000404, $48606828, $41717031,
    $07030407, $cbd3d81b, $8d919c1d, $89919819, $41616021, $8eb2bc3e, $c6e2e426, $49515819,
    $cdd1dc1d, $41515011, $80909010, $ccd0dc1c, $8a92981a, $83a3a023, $8ba3a82b, $c0d0d010,
    $81818001, $0f030c0f, $47434407, $0a12181a, $c3e3e023, $cce0ec2c, $8d818c0d, $8fb3bc3f,
    $86929416, $4b73783b, $4c505c1c, $82a2a022, $81a1a021, $43636023, $03232023, $4d414c0d,
    $c8c0c808, $8e929c1e, $8c909c1c, $0a32383a, $0c000c0c, $0e222c2e, $8ab2b83a, $4e626c2e,
    $8f939c1f, $4a52581a, $c2f2f032, $82929012, $c3f3f033, $49414809, $48707838, $ccc0cc0c,
    $05111415, $cbf3f83b, $40707030, $45717435, $4f737c3f, $05313435, $00101010, $03030003,
    $44606424, $4d616c2d, $c6c2c406, $44707434, $c5d1d415, $84b0b434, $cae2e82a, $09010809,
    $46727436, $09111819, $cef2fc3e, $40404000, $02121012, $c0e0e020, $8db1bc3d, $05010405,
    $caf2f83a, $01010001, $c0f0f030, $0a22282a, $4e525c1e, $89a1a829, $46525416, $43434003,
    $85818405, $04101414, $89818809, $8b93981b, $80b0b030, $c5e1e425, $48404808, $49717839,
    $87939417, $ccf0fc3c, $0e121c1e, $82828002, $01212021, $8c808c0c, $0b13181b, $4f535c1f,
    $47737437, $44505414, $82b2b032, $0d111c1d, $05212425, $4f434c0f, $00000000, $46424406,
    $cde1ec2d, $48505818, $42525012, $cbe3e82b, $4e727c3e, $cad2d81a, $c9c1c809, $cdf1fc3d,
    $00303030, $85919415, $45616425, $0c303c3c, $86b2b436, $c4e0e424, $8bb3b83b, $4c707c3c,
    $0e020c0e, $40505010, $09313839, $06222426, $02323032, $84808404, $49616829, $83939013,
    $07333437, $c7e3e427, $04202424, $84a0a424, $cbc3c80b, $43535013, $0a02080a, $87838407,
    $c9d1d819, $4c404c0c, $83838003, $8f838c0f, $cec2cc0e, $0b33383b, $4a42480a, $87b3b437
  );

  KC        : Array[0..15] of DWORD = (
    $9e3779b9, $3c6ef373, $78dde6e6, $f1bbcdcc, $e3779b99, $c6ef3733, $8dde6e67, $1bbcdccf,
    $3779b99e, $6ef3733c, $dde6e678, $bbcdccf1, $779b99e3, $ef3733c6, $de6e678d, $bcdccf1b
  );

  Procedure SeedEncrypt(var pbData: Array of BYTE; var pdwRoundKey: Array of LongWord);
  Procedure SeedDecrypt(var pbData: Array of BYTE; var pdwRoundKey: Array of LongWord);
  Procedure SeedEncRoundKey(var pdwRoundKey: Array of LongWord; var pbUserKey: Array of BYTE);

var
  gSeedRoundKey : array[0..31] of LongWord;
  gSeedUserKey  : array[0..15] of Byte = ($50, $17, $30, $06, $05, $14, $73, $99,
                                          $00, $00, $77, $55, $13, $11, $07, $08);
implementation

Function GetB0(const x: Integer): Integer;
begin
    Result := $000000ff and x;
end;

Function GetB1(const x: Integer): Integer;
begin
    Result := $000000ff and (x shr 8);
end;

Function GetB2(const x: Integer): Integer;
begin
    Result := $000000ff and (x shr 16);
end;

Function GetB3(const x: Integer): Integer;
begin
    Result := $000000ff and (x shr 24);
end;

procedure EndianChange(var dws: Array of Integer); overload;
begin
    dws[0]  := (dws[0] shr 24) or (dws[0] shl 24) or ((dws[0] shl 8) and $00ff0000) or ((dws[0] shr 8) and $0000ff00);
end;
Function EndianChange(dws: Integer): Integer; overload;
begin
    Result      := (dws shr 24) or (dws shl 24) or ((dws shl 8) and $00ff0000) or ((dws shr 8) and $0000ff00);
end;

procedure EncRoundKeyUpdate0(var K: TArrList;var A, B, C, D: Integer; Z: Integer);
var
    T0, T1, T00, T11        : Integer;
begin
    T0      := A;
    A    := (A shr 8) xor (B shl 24);
    B    := (B shr 8) xor (T0 shl 24);
    T00     := A + C - KC[Z];
    T11     := B + KC[Z] - D;
    K[0]    := SS0[GetB0(T00)] xor SS1[GetB1(T00)] xor SS2[GetB2(T00)] xor SS3[GetB3(T00)];
    K[1]    := SS0[GetB0(T11)] xor SS1[GetB1(T11)] xor SS2[GetB2(T11)] xor SS3[GetB3(T11)];
end;

procedure EncRoundKeyUpdate1(var K: TArrList;var A, B, C, D: Integer; Z: Integer);
var
    T0, T1, T00, T11        : Integer;
begin
    T0      := C;
    C    := (C shl 8) xor (D shr 24);
    D    := (D shl 8) xor (T0 shr 24);
    T00     := A + C - KC[Z];
    T11     := B + KC[Z] - D;
    K[0]    := SS0[GetB0(T00)] xor SS1[GetB1(T00)] xor SS2[GetB2(T00)] xor SS3[GetB3(T00)];
    K[1]    := SS0[GetB0(T11)] xor SS1[GetB1(T11)] xor SS2[GetB2(T11)] xor SS3[GetB3(T11)];
end;

procedure SeedRound(var L0, L1, R0, R1: LongWord;var K: TArrList);
var
    T0, T1      : LongWord;
    T00, T11    : LongWord;
begin
    T00     := 0;
    T11     := 0;
    T0 := R0 xor K[0];
    T1 := R1 xor K[1];
    T1 := T1 xor T0;

    if (T0 < 0) then
        T00 := (T0 and $7fffffff) or ($80000000)
    else
        T00 := T0;

    T1 := SS0[GetB0(T1)] xor SS1[GetB1(T1)] xor SS2[GetB2(T1)] xor SS3[GetB3(T1)];

    if (T1 < 0) then
        T11 := (T1 and $7fffffff) or ($80000000)
    else
        T11 := T1;

    T00 := T00 + T11;
    T0 := SS0[GetB0(T00)] xor SS1[GetB1(T00)] xor SS2[GetB2(T00)] xor SS3[GetB3(T00)];

    if (T0 < 0) then
        T00 := (T0 and $7fffffff) or ($80000000)
    else
        T00 := T0;

    T11 := T11 + T00;
    T1 := SS0[GetB0(T11)] xor SS1[GetB1(T11)] xor SS2[GetB2(T11)] xor SS3[GetB3(T11)];

    if (T1 < 0) then
        T11 := (T1 and $7fffffff) or ($80000000)
    else
        T11 := T1;

    T00 := T00 + T11;
    L0 := L0 xor T00;
    L1 := L1 xor T11;
end;

Procedure SeedEncrypt(var pbData: Array of BYTE; var pdwRoundKey: Array of LongWord);
var
    L0, L1, R0, R1  : LongWord;
    K               : TArrList;
    nCount          : Integer;
    i               : Integer;
begin
    L0              := $0;
    L1              := $0;
    R0              := $0;
    R1              := $0;

    nCount          := 0;

    L0              := pbData[0] and $000000ff;
    L0              := (L0 shl 8) xor (pbData[1] and $000000ff);
    L0              := (L0 shl 8) xor (pbData[2] and $000000ff);
    L0              := (L0 shl 8) xor (pbData[3] and $000000ff);

    L1              := pbData[4] and $000000ff;
    L1              := (L1 shl 8) xor (pbData[5] and $000000ff);
    L1              := (L1 shl 8) xor (pbData[6] and $000000ff);
    L1              := (L1 shl 8) xor (pbData[7] and $000000ff);

    R0              := pbData[8] and $000000ff;
    R0              := (R0 shl 8) xor (pbData[9] and $000000ff);
    R0              := (R0 shl 8) xor (pbData[10] and $000000ff);
    R0              := (R0 shl 8) xor (pbData[11] and $000000ff);

    R1              := pbData[12] and $000000ff;
    R1              := (R1 shl 8) xor (pbData[13] and $000000ff);
    R1              := (R1 shl 8) xor (pbData[14] and $000000ff);
    R1              := (R1 shl 8) xor (pbData[15] and $000000ff);

    if (ENDIAN) then
    begin
        L0       := EndianChange(L0);
        L1       := EndianChange(L1);
        R0       := EndianChange(R0);
        R1       := EndianChange(R1);
    end;

    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(L0, L1, R0, R1, K);
    K[0]            := pdwRoundKey[nCount];
    Inc(nCount);
    K[1]            := pdwRoundKey[nCount];
    Inc(nCount);
    SeedRound(R0, R1, L0, L1, K);

    if (NoRounds = 16) then
    begin
        K[0]            := pdwRoundKey[nCount];
        Inc(nCount);
        K[1]            := pdwRoundKey[nCount];
        Inc(nCount);
        SeedRound(L0, L1, R0, R1, K);
        K[0]            := pdwRoundKey[nCount];
        Inc(nCount);
        K[1]            := pdwRoundKey[nCount];
        Inc(nCount);
        SeedRound(R0, R1, L0, L1, K);
        K[0]            := pdwRoundKey[nCount];
        Inc(nCount);
        K[1]            := pdwRoundKey[nCount];
        Inc(nCount);
        SeedRound(L0, L1, R0, R1, K);
        K[0]            := pdwRoundKey[nCount];
        Inc(nCount);
        K[1]            := pdwRoundKey[nCount];
        Inc(nCount);
        SeedRound(R0, R1, L0, L1, K);
    end;

    if (ENDIAN) then
    begin
        L0      := EndianChange(L0);
        L1      := EndianChange(L1);
        R0      := EndianChange(R0);
        R1      := EndianChange(R1);
    end;

    for i := 0 to 3 do
    begin
        pbData[i]  := (R0 shr (8 * (3 - i))) and $ff;
        pbData[4 + i] := (R1 shr (8 * (3 - i))) and $ff;
        pbData[8 + i] := (L0 shr (8 * (3 - i))) and $ff;
        pbData[12 + i] := (L1 shr (8 * (3 - i))) and $ff;
    end;

end;

Procedure SeedDecrypt(var pbData: Array of BYTE; var pdwRoundKey: Array of LongWord);
var
    L0, L1, R0, R1  : LongWord;
    K               : TArrList;
    nCount          : Integer;
    i               : Integer;
begin
    L0          := $0;
    L1          := $0;
    R0          := $0;
    R1          := $0;
    nCount      := 31;

    L0          := pbData[0] and $000000ff;
    L0          := (L0 shl 8) xor (pbData[1] and $000000ff);
    L0          := (L0 shl 8) xor (pbData[2] and $000000ff);
    L0          := (L0 shl 8) xor (pbData[3] and $000000ff);

    L1          := pbData[4] and $000000ff;
    L1          := (L1 shl 8) xor (pbData[5] and $000000ff);
    L1          := (L1 shl 8) xor (pbData[6] and $000000ff);
    L1          := (L1 shl 8) xor (pbData[7] and $000000ff);

    R0          := pbData[8] and $000000ff;
    R0          := (R0 shl 8) xor (pbData[9] and $000000ff);
    R0          := (R0 shl 8) xor (pbData[10] and $000000ff);
    R0          := (R0 shl 8) xor (pbData[11] and $000000ff);

    R1          := pbData[12] and $000000ff;
    R1          := (R1 shl 8) xor (pbData[13] and $000000ff);
    R1          := (R1 shl 8) xor (pbData[14] and $000000ff);
    R1          := (R1 shl 8) xor (pbData[15] and $000000ff);

    if (ENDIAN) then
    begin
        L0       := EndianChange(L0);
        L1       := EndianChange(L1);
        R0       := EndianChange(R0);
        R1       := EndianChange(R1);
    end;

    if (NoRounds = 16) then
    begin
        K[1]        := pdwRoundKey[nCount];
        Dec(nCount);
        K[0]        := pdwRoundKey[nCount];
        Dec(nCount);
        SeedRound(L0, L1, R0, R1, K);

        K[1]        := pdwRoundKey[nCount];
        Dec(nCount);
        K[0]        := pdwRoundKey[nCount];
        Dec(nCount);
        SeedRound(R0, R1, L0, L1, K);

        K[1]        := pdwRoundKey[nCount];
        Dec(nCount);
        K[0]        := pdwRoundKey[nCount];
        Dec(nCount);
        SeedRound(L0, L1, R0, R1, K);

        K[1]        := pdwRoundKey[nCount];
        Dec(nCount);
        K[0]        := pdwRoundKey[nCount];
        Dec(nCount);
        SeedRound(R0, R1, L0, L1, K);
    end;

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(L0, L1, R0, R1, K);

    K[1]        := pdwRoundKey[nCount];
    Dec(nCount);
    K[0]        := pdwRoundKey[nCount];
    Dec(nCount);
    SeedRound(R0, R1, L0, L1, K);

    if (ENDIAN) then
    begin
        L0       := EndianChange(L0);
        L1       := EndianChange(L1);
        R0       := EndianChange(R0);
        R1       := EndianChange(R1);
    end;

    for i := 0 to 3 do
    begin
        pbData[i]       := (R0 shr (8 * (3 - i))) and $ff;
        pbData[4 + i]   := (R1 shr (8 * (3 - i))) and $ff;
        pbData[8 + i]   := (L0 shr (8 * (3 - i))) and $ff;
        pbData[12 + i]  := (L1 shr (8 * (3 - i))) and $ff;
    end;
end;

Procedure SeedEncRoundKey(var pdwRoundKey: Array of LongWord; var pbUserKey: Array of BYTE);
var
    A, B, C, D  : Integer;
    K           : TArrList;
    T0, T1, nCount  : LongWord;
begin
    nCount      := 2;

    A       := pbUserKey[0] and $000000ff;
    A       := (A shl 8) or (pbUserKey[1] and $000000ff);
    A       := (A shl 8) or (pbUserKey[2] and $000000ff);
    A       := (A shl 8) or (pbUserKey[3] and $000000ff);

    B       := pbUserKey[4] and $000000ff;
    B       := (B shl 8) or (pbUserKey[5] and $000000ff);
    B       := (B shl 8) or (pbUserKey[6] and $000000ff);
    B       := (B shl 8) or (pbUserKey[7] and $000000ff);

    C       := pbUserKey[8] and $000000ff;
    C       := (C shl 8) or (pbUserKey[9] and $000000ff);
    C       := (C shl 8) or (pbUserKey[10] and $000000ff);
    C       := (C shl 8) or (pbUserKey[11] and $000000ff);

    D       := pbUserKey[12] and $000000ff;
    D       := (D shl 8) or (pbUserKey[13] and $000000ff);
    D       := (D shl 8) or (pbUserKey[14] and $000000ff);
    D       := (D shl 8) or (pbUserKey[15] and $000000ff);

    if (ENDIAN) then
    begin
        A       := EndianChange(A);
        B       := EndianChange(B);
        C       := EndianChange(C);
        D       := EndianChange(D);
    end;

    T0      := A + C - KC[0];
    T1      := B - D + KC[0];

    pdwRoundKey[0]  := SS0[GetB0(T0)] xor SS1[GetB1(T0)] xor SS2[GetB2(T0)] xor SS3[GetB3(T0)];
    pdwRoundKey[1]  := SS0[GetB0(T1)] xor SS1[GetB1(T1)] xor SS2[GetB2(T1)] xor SS3[GetB3(T1)];

    EncRoundKeyUpdate0(K, A, B, C, D, 1);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);

    EncRoundKeyUpdate1(K, A, B, C, D, 2);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate0(K, A, B, C, D, 3);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate1(K, A, B, C, D, 4);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate0(K, A, B, C, D, 5);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate1(K, A, B, C, D, 6);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate0(K, A, B, C, D, 7);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate1(K, A, B, C, D, 8);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate0(K, A, B, C, D, 9);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate1(K, A, B, C, D, 10);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);
    EncRoundKeyUpdate0(K, A, B, C, D, 11);
    pdwRoundKey[nCount] := K[0];
    Inc(nCount);
    pdwRoundKey[nCount] := K[1];
    Inc(nCount);

    if (NoRounds = 16) then
    begin
        EncRoundKeyUpdate1(K, A, B, C, D, 12);
        pdwRoundKey[nCount] := K[0];
        Inc(nCount);
        pdwRoundKey[nCount] := K[1];
        Inc(nCount);
        EncRoundKeyUpdate0(K, A, B, C, D, 13);
        pdwRoundKey[nCount] := K[0];
        Inc(nCount);
        pdwRoundKey[nCount] := K[1];
        Inc(nCount);
        EncRoundKeyUpdate1(K, A, B, C, D, 14);
        pdwRoundKey[nCount] := K[0];
        Inc(nCount);
        pdwRoundKey[nCount] := K[1];
        Inc(nCount);
        EncRoundKeyUpdate0(K, A, B, C, D, 15);
        pdwRoundKey[nCount] := K[0];
        Inc(nCount);
        pdwRoundKey[nCount] := K[1];
        Inc(nCount);
    end;
end;

end.
