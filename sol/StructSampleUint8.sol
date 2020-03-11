//-----------------------------------------------------------------
// このコントラクトでは[solidity ver 0.4]系の脆弱性を利用する
//（※[solidity ver 0.5]系以降でコンパイルするとエラーがでるので注意）
//-----------------------------------------------------------------
pragma solidity ^0.4.24;

contract StructSampleUint8{
  //---------------------------------------------
  // テスト構造体：uint8 だけのケース
  //---------------------------------------------
  struct MyStruct {
    // 1st word
    uint8   val8;
    // padding 248 bits
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
  MyStruct[4] internal arrForCheck;

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
    arrForCheck[0].val8 = uint8( 0x80 );
    arrForCheck[1].val8 = uint8( 0x81 );
    arrForCheck[2].val8 = uint8( 0x82 );
    arrForCheck[3].val8 = uint8( 0x83 );
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
