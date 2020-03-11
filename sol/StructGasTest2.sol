pragma solidity >= 0.5.0 < 0.7.0;

//----------------------
// 構造体のガステスト２
//----------------------
contract StructGassTest2{

  // テスト構造体
  struct MyStruct {
    uint32    rscId;
    uint16    hp;
    uint16    mp;
    uint16    attack;
    uint16    guard;
    uint16    speed;
    uint16    luck;
    uint8[16] arrDNA;
  }

  // 構造体の動的配列（※データを参照できるように公開しておく）
  MyStruct[] public arrStruct;

	//-------------------------------------------
  // コンストラクタ
	//-------------------------------------------
	constructor() public {
    // データを一つ作っておく
    createStruct( 0 );
	}

  //-------------------------------------------
  // 要素数の取得
  //-------------------------------------------
  function getTotalStruct() public view returns( uint256 ){
    return arrStruct.length;
  }

	//-------------------------------------------
 	// 構造体を新規作成して配列へ追加
	//-------------------------------------------
	function createStruct( uint256 _val256 ) public{
    // メモリ上にインスタンスの作成
    MyStruct memory newStruct = MyStruct({
      rscId:uint32(_val256),
      hp:uint16(_val256),
      mp:uint16(_val256),
      attack:uint16(_val256),
      guard:uint16(_val256),
      speed:uint16(_val256),
      luck:uint16(_val256),
      arrDNA:[
        uint8(_val256), uint8(_val256), uint8(_val256), uint8(_val256),
        uint8(_val256), uint8(_val256), uint8(_val256), uint8(_val256),
        uint8(_val256), uint8(_val256), uint8(_val256), uint8(_val256),
        uint8(_val256), uint8(_val256), uint8(_val256), uint8(_val256)
      ]
    });

    // 配列に追加
		arrStruct.push( newStruct );
	}

	//-------------------------------------------
 	// 直接代入して更新
	//-------------------------------------------
  function updateDirect( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    arrStruct[_at].rscId = uint32(_val256);
    arrStruct[_at].hp = uint16(_val256);
    arrStruct[_at].mp = uint16(_val256);
    arrStruct[_at].attack = uint16(_val256);
    arrStruct[_at].guard = uint16(_val256);
    arrStruct[_at].speed = uint16(_val256);
    arrStruct[_at].luck = uint16(_val256);
    for( uint i=0; i<16; i++ ){
      arrStruct[_at].arrDNA[i] = uint8(_val256);
    }
  }

	//-------------------------------------------
 	// ストレージ変数経由で更新
	//-------------------------------------------
  function updateViaStorage( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    MyStruct storage stoStruct = arrStruct[_at];
    stoStruct.rscId = uint32(_val256);
    stoStruct.hp = uint16(_val256);
    stoStruct.mp = uint16(_val256);
    stoStruct.attack = uint16(_val256);
    stoStruct.guard = uint16(_val256);
    stoStruct.speed = uint16(_val256);
    stoStruct.luck = uint16(_val256);
    for( uint i=0; i<16; i++ ){
      stoStruct.arrDNA[i] = uint8(_val256);
    }
  }

	//-------------------------------------------
 	// メモリ上で編集した構造体で更新
	//-------------------------------------------
  function updateViaMemory( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    MyStruct memory memStruct = arrStruct[_at];
    memStruct.rscId = uint32(_val256);
    memStruct.hp = uint16(_val256);
    memStruct.mp = uint16(_val256);
    memStruct.attack = uint16(_val256);
    memStruct.guard = uint16(_val256);
    memStruct.speed = uint16(_val256);
    memStruct.luck = uint16(_val256);
    for( uint i=0; i<16; i++ ){
      memStruct.arrDNA[i] = uint8(_val256);
    }

    arrStruct[_at] = memStruct;
  }
}
