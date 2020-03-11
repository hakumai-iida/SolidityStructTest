pragma solidity >= 0.5.0 < 0.7.0;

//----------------------
// 構造体のガステスト
//----------------------
contract StructGassTest{

  // テスト構造体
  struct MyStruct {
    uint256 val256;
    uint160 val160;
    uint64  val64;
    uint32  val32;
    address addr160;
    uint16  val16;
    uint8   val8;
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
        val256: uint256(_val256),
        val160: uint160(_val256),
        val64: uint64(_val256),
        val32: uint32(_val256),
        addr160: address(_val256),
        val16: uint16(_val256),
        val8: uint8(_val256)
    });

    // 配列に追加
		arrStruct.push( newStruct );
	}

  //-------------------------------------------
  // address と uint160 の比較
  //-------------------------------------------
  // address
  function updateAddress( uint256 _at, address _addr160 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    arrStruct[_at].addr160 = _addr160;
  }

  // uint160
  function updateUint160( uint256 _at, uint160 _val160 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    arrStruct[_at].val160 = _val160;
  }

  // uint160 で渡した値を address として使ってみる
  function getBalanceWithUint160( uint160 _val160 ) public view returns( uint256 ){
    address addr160 = address( _val160 );
    return addr160.balance;
  }

  // address で渡した値を uint160 として使ってみる
  function div256WithAddress( address _addr160 ) public pure returns( uint160 ){
    uint160 val160 = uint160( _addr160 );
    val160 = val160 / 256;
    return val160;
  }

	//-------------------------------------------
 	// 直接代入して更新
	//-------------------------------------------
  // uint8
	function updateDirectUint8( uint256 _at, uint8 _val8 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // 直接書き込み
    arrStruct[_at].val8 = _val8;
	}

 	// uint256
	function updateDirectUint256( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // 直接書き込み
    arrStruct[_at].val256 = _val256;
	}

  // 全部の変数
  function updateDirectAll( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // 直接書き込み
    arrStruct[_at].val256 = uint256(_val256);
    arrStruct[_at].val160 = uint160(_val256);
    arrStruct[_at].val64 = uint64(_val256);
    arrStruct[_at].val32 = uint32(_val256);
    arrStruct[_at].addr160 = address(_val256);
    arrStruct[_at].val16 = uint16(_val256);
    arrStruct[_at].val8 = uint8(_val256);
  }

	//-------------------------------------------
 	// ストレージ変数経由で更新
	//-------------------------------------------
  // uint8
	function updateViaStorageUint8( uint256 _at, uint8 _val8 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // ストレージ変数に経由で書き込み
    MyStruct storage stoStruct = arrStruct[_at];
    stoStruct.val8 = _val8;
	}

 	// uint256
	function updateViaStorageUint256( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // ストレージ変数に経由で書き込み
    MyStruct storage stoStruct = arrStruct[_at];
    stoStruct.val256 = _val256;
	}

  // 全部の変数
  function updateViaStorageAll( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // ストレージ変数に経由で書き込み
    MyStruct storage stoStruct = arrStruct[_at];
    stoStruct.val256 = uint256(_val256);
    stoStruct.val160 = uint160(_val256);
    stoStruct.val64 = uint64(_val256);
    stoStruct.val32 = uint32(_val256);
    stoStruct.addr160 = address(_val256);
    stoStruct.val16 = uint16(_val256);
    stoStruct.val8 = uint8(_val256);
  }

	//-------------------------------------------
 	// メモリ上で編集した構造体で更新
	//-------------------------------------------
  // uint8
	function updateViaMemoryUint8( uint256 _at, uint8 _val8 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // メモリ上で更新してから構造体を上書き
    MyStruct memory memStruct = arrStruct[_at];
    memStruct.val8 = _val8;
    arrStruct[_at] = memStruct;
	}

  // uint256
	function updateViaMemoryUint256( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // メモリ上で更新してから構造体を上書き
    MyStruct memory memStruct = arrStruct[_at];
    memStruct.val256 = _val256;
    arrStruct[_at] = memStruct;
	}

  // 全部の変数
  function updateViaMemoryAll( uint256 _at, uint256 _val256 ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // メモリ上で更新してから構造体を上書き
    MyStruct memory memStruct = arrStruct[_at];
    memStruct.val256 = uint256(_val256);
    memStruct.val160 = uint160(_val256);
    memStruct.val64 = uint64(_val256);
    memStruct.val32 = uint32(_val256);
    memStruct.addr160 = address(_val256);
    memStruct.val16 = uint16(_val256);
    memStruct.val8 = uint8(_val256);
    arrStruct[_at] = memStruct;
  }

  //------------------------------------------------
  // うっかりストレージで宣言した変数で作業した上で書き込み
  //------------------------------------------------
  function updateCarelesslyAll( uint256 _at ) public{
    require( _at >= 0 && _at < arrStruct.length );

    // ストレージ変数をメモリと思い込んで作業してみる
    MyStruct storage notMemStruct = arrStruct[_at];
    notMemStruct.val256 = uint256( notMemStruct.val256 + 1 );
    notMemStruct.val160 = uint160( notMemStruct.val160 + 1 );
    notMemStruct.val64 = uint64( notMemStruct.val64 + 1 );
    notMemStruct.val32 = uint32( notMemStruct.val32 + 1 );
    notMemStruct.addr160 = address( uint160(notMemStruct.addr160) + 1 );
    notMemStruct.val16 = uint16( notMemStruct.val16 + 1 );
    notMemStruct.val8 = uint8( notMemStruct.val8 + 1 );

    // メモリのつもりなので元データへ反映させてしまう
    arrStruct[_at] = notMemStruct;
  }
}
