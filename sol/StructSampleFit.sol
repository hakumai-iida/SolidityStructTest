//-----------------------------------------------------------------
// このコントラクトでは[solidity ver 0.4]系の脆弱性を利用する
//（※[solidity ver 0.5]系以降でコンパイルするとエラーがでるので注意）
//-----------------------------------------------------------------
pragma solidity ^0.4.24;

contract StructSampleFit{
  //---------------------------------------------
  // テスト構造体：収まりのよいケース
  //---------------------------------------------
  struct MyStruct {
    // 1st word
    uint256 val256;

    // 2nd word
    uint160 val160;
    uint64  val64;
    uint32  val32;

    // 3rd word
    address addr160;
    uint16  val16;
    uint8   val8;
    // padding 72 bits
  }

  //---------------------------------------------
  // [MyStruct]をワード単位で参照するための構造体
  //---------------------------------------------
  struct Word8 {
    uint256 word0;
    uint256 word1;
    uint256 word2;
    uint256 word3;
    uint256 word4;
    uint256 word5;
    uint256 word6;
    uint256 word7;
  }

  //---------------------------------------------
  // [Word8]に参照されるように"slot[0]"へ配置する
  //---------------------------------------------
  MyStruct internal structForCheck;

  // 用心に[structForCheck]の後を８ワード分のダミーデータで埋める
  uint256 internal _padding1 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding2 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding3 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding4 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding5 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding6 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  uint256 internal _padding7 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

  //-------------------------------------------
  // コンストラクタ
  //-------------------------------------------
  constructor() public {
    // チェック用の構造体の各要素にわかりやすい値を設定
    structForCheck.addr160  = address( 0xadADADadAdADAdadADADADadadADAdAdadaDAdAD );
    structForCheck.val256   = uint256( 0x2562562562562562562562562562562562562562562562562562562562562562 );
    structForCheck.val160   = uint160( 0x1601601601601601601601601601601601601601 );
    structForCheck.val64    = uint64( 0x6464646464646464 );
    structForCheck.val32    = uint32( 0x32323232 );
    structForCheck.val16    = uint16( 0x1616 );
    structForCheck.val8     = uint8( 0x88 );
  }

  //-------------------------------------------
  // 構造体の内容を８ワードで受け取る
  //-------------------------------------------
  function getStructAsWords() view public returns(
    uint256 word0,
    uint256 word1,
    uint256 word2,
    uint256 word3,
    uint256 word4,
    uint256 word5,
    uint256 word6,
    uint256 word7
  ){
    //-----------------------------------------------------------------
    // あえて未初期化のストレージ変数へアクセスする（※警告が出るが気にしない）
    //-----------------------------------------------------------------
    // EVMの特性として、未初期化のストレージ変数は"slot[0]"を参照するので、
    // 下記のストレージ変数[word8]は[structForCheck]の領域へアクセスする
    //-----------------------------------------------------------------
    Word8 storage word8;
    word0 = word8.word0;
    word1 = word8.word1;
    word2 = word8.word2;
    word3 = word8.word3;
    word4 = word8.word4;
    word5 = word8.word5;
    word6 = word8.word6;
    word7 = word8.word7;
  }  
}
