pragma solidity >= 0.5.0 < 0.7.0;

//----------------------
// 構造体のガステスト３
//----------------------
contract StructGassTest3{

  // テスト構造体
  struct MyStruct {
    uint32    rscId;
    uint16    hp;
    uint16    mp;
    uint16    attack;
    uint16    guard;
    uint16    speed;
    uint16    luck;

    uint32    dnaType;
    uint16    dna0;
    uint16    dna1;
    uint16    dna2;
    uint16    dna3;
    uint16    dna4;
    uint16    dna5;
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
    MyStruct memory newStruct;
    newStruct.rscId = uint32(_val256);
    newStruct.hp = uint16(_val256);
    newStruct.mp = uint16(_val256);
    newStruct.attack = uint16(_val256);
    newStruct.guard = uint16(_val256);
    newStruct.speed = uint16(_val256);
    newStruct.luck = uint16(_val256);
    newStruct.dnaType = uint32(_val256);
    newStruct.dna0 = uint16(_val256);
    newStruct.dna1 = uint16(_val256);
    newStruct.dna2 = uint16(_val256);
    newStruct.dna3 = uint16(_val256);
    newStruct.dna4 = uint16(_val256);
    newStruct.dna5 = uint16(_val256);
    
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
    arrStruct[_at].dnaType = uint32(_val256);
    arrStruct[_at].dna0 = uint16(_val256);
    arrStruct[_at].dna1 = uint16(_val256);
    arrStruct[_at].dna2 = uint16(_val256);
    arrStruct[_at].dna3 = uint16(_val256);
    arrStruct[_at].dna4 = uint16(_val256);
    arrStruct[_at].dna5 = uint16(_val256);
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
    stoStruct.dnaType = uint32(_val256);
    stoStruct.dna0 = uint16(_val256);
    stoStruct.dna1 = uint16(_val256);
    stoStruct.dna2 = uint16(_val256);
    stoStruct.dna3 = uint16(_val256);
    stoStruct.dna4 = uint16(_val256);
    stoStruct.dna5 = uint16(_val256);
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
    memStruct.dnaType = uint32(_val256);
    memStruct.dna0 = uint16(_val256);
    memStruct.dna1 = uint16(_val256);
    memStruct.dna2 = uint16(_val256);
    memStruct.dna3 = uint16(_val256);
    memStruct.dna4 = uint16(_val256);
    memStruct.dna5 = uint16(_val256);

    arrStruct[_at] = memStruct;
  }
}
