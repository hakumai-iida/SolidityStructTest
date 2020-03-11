//
//  TestSolidityStruct.swift
//  SolidityStructTest
//
//  Created by 飯田白米 on 2020/03/11.
//  Copyright © 2020 飯田白米. All rights reserved.
//

import Foundation
import UIKit
import BigInt
import web3swift

class TestSolidityStruct {
    //-------------------------
    // メンバー
    //-------------------------
    let helper: Web3Helper              // [web3swift]利用のためのヘルパー
    let keyFile: String                 // 直近に作成されたキーストアを保持するファイル
    let password: String                // アカウント作成時のパスワード
    let targetNet: Web3Helper.target    // 接続先
    var isBusy = false                  // 重複呼び出し回避用

    //-------------------------
    // イニシャライザ
    //-------------------------
    public init(){
        // ヘルパー作成
        self.helper = Web3Helper()
    
        // キーストアファイル
        self.keyFile = "key.json"

        // FIXME ご自身のパスワードで置き換えてください
        // メモ：このコードはテスト用なのでソース内にパスワードを書いていますが、
        //      公開を前提としたアプリを作る場合、ソース内にパスワードを書くことは大変危険です！
        self.password = "password"
                
        // FIXME ご自身のテストに合わせて接続先を変更してください
        self.targetNet = Web3Helper.target.rinkeby
    }

    //-------------------------
    // テストの開始
    //-------------------------
    public func test() {
        // テスト中なら無視
        if( self.isBusy ){
            print( "@ TestSolidityStruct: busy!" )
            return;
        }
        self.isBusy = true;
        
        // キュー（メインとは別のスレッド）で処理する
        let queue = OperationQueue()
        queue.addOperation {
            self.execTest()
            self.isBusy = false;
        }
    }

    //-------------------------
    // テストの開始
    //-------------------------
    func execTest() {
        print( "@-----------------------------" )
        print( "@ TestSolidityStruct: start..." )
        print( "@-----------------------------" )

        do{
            // 接続先の設定
            self.setTarget()
            
            // キーストア（イーサリアムアドレス）の設定
            self.setKeystore()
            
            // 構造体の確認
            try self.checkStructBasic()
            try self.checkStructWorst()
            try self.checkStructFit()
            try self.checkStructUint8()

            // 残高の確認
            self.checkBalance()
            
            // データ更新の確認１
            try self.checkUpdate();
            
            // データ更新の確認２
            try self.checkUpdate2();
            
            // データ更新の確認３
            try self.checkUpdate3();
        } catch {
            print( "@ TestSolidityStruct: error:", error )
        }
        
        print( "@-----------------------------" )
        print( "@ TestSolidityStruct: finished" )
        print( "@-----------------------------" )
    }

    //-----------------------------------------
    // JSONファイルの保存
    //-----------------------------------------
    func saveKeystoreJson( json : String ) -> Bool{
        let userDir = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true )[0]
        let keyPath = userDir + "/" + self.keyFile
        return FileManager.default.createFile( atPath: keyPath, contents: json.data( using: .ascii ), attributes: nil )
    }
    
    //-----------------------------------------
    // JSONファイルの読み込み
    //-----------------------------------------
    func loadKeystoreJson() -> String?{
        let userDir = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true )[0]
        let keyPath = userDir + "/" + self.keyFile
        return try? String( contentsOfFile: keyPath, encoding: String.Encoding.ascii )
    }

    //-----------------------------------------
    // 接続先設定
    //-----------------------------------------
    func setTarget(){
        print( "@------------------" )
        print( "@ setTarget" )
        print( "@------------------" )
        _ = self.helper.setTarget( target: self.targetNet )
        
        let target = self.helper.getCurTarget()
        print( "@ target:", target! )
    }

    //-----------------------------------------
    // キーストア設定
    //-----------------------------------------
    func setKeystore() {
        print( "@------------------" )
        print( "@ setKeystore" )
        print( "@------------------" )

        // キーストアのファイルを読み込む
        if let json = self.loadKeystoreJson(){
            print( "@ loadKeystoreJson: json=", json )

            let result = helper.loadKeystore( json: json )
            print( "@ loadKeystore: result=", result )
        }
        
        // この時点でヘルパーが無効であれば新規キーストアの作成
        if !helper.isValid() {
            if helper.createNewKeystore(password: self.password){
                print( "@ CREATE NEW KEYSTORE" )
                
                let json = helper.getCurKeystoreJson()
                print( "@ Write down below json code to import generated account into your wallet apps(e.g. MetaMask)" )
                print( json! )

                let privateKey = helper.getCurPrivateKey( password : self.password )
                print( "@ privateKey:", privateKey! )

                // 出力
                let result = self.saveKeystoreJson( json: json! )
                print( "@ saveKeystoreJson: result=", result )
            }
        }

        // イーサリアムアドレスの確認
        let ethereumAddress = helper.getCurEthereumAddress()
        print( "@ CURRENT KEYSTORE" )
        print( "@ ethereumAddress:", ethereumAddress! )
    }

    //--------------------------
    // 構造体の確認
    //--------------------------
    // Basic
    func checkStructBasic() throws{
        print( "@---------------------" )
        print( "@ checkStructBasic" )
        print( "@---------------------" )

        let contract = StructSampleBasic()
        let words = try contract.getStructAsWords( self.helper )
        
        for i in 0 ..< 8 {
            print( "w[\(i)]:", bi2HexString( words[i], 64 ) );
        }
    }

    // Worst
    func checkStructWorst() throws{
        print( "@---------------------" )
        print( "@ checkStructWorst" )
        print( "@---------------------" )

        let contract = StructSampleWorst()
        let words = try contract.getStructAsWords( self.helper )
        
        for i in 0 ..< 8 {
            print( "w[\(i)]:", bi2HexString( words[i], 64 ) );
        }
    }

    // Fit
    func checkStructFit() throws{
        print( "@---------------------" )
        print( "@ checkStructFit" )
        print( "@---------------------" )

        let contract = StructSampleFit()
        let words = try contract.getStructAsWords( self.helper )
        
        for i in 0 ..< 8 {
            print( "w[\(i)]:", bi2HexString( words[i], 64 ) );
        }
    }

    // Uint8
    func checkStructUint8() throws{
        print( "@---------------------" )
        print( "@ checkStructUint8" )
        print( "@---------------------" )

        let contract = StructSampleUint8()
        let words = try contract.getStructAsWords( self.helper )
        
        for i in 0 ..< 8 {
            print( "w[\(i)]:", bi2HexString( words[i], 64 ) );
        }
    }

    // BigUIntを０詰めの１６進数文字列へ変換
    func bi2HexString( _ val:BigUInt, _ len:Int ) -> String {
        var str = String( val, radix: 16 );
        var at = str.count;
        while at < len {
            str = "0" + str
            at += 1
        }
        
        return str
    }
    
    //------------------------
    // 残高確認
    //------------------------
    func checkBalance() {
        print( "@------------------" )
        print( "@ checkBalance" )
        print( "@------------------" )
        
        let balance = self.helper.getCurBalance()
        print( "@ balance:", balance!, "wei" )
    }
    
    //--------------------------
    // 構造体の更新確認
    //--------------------------
    func checkUpdate() throws{
        print( "@------------------" )
        print( "@ checkUpdate" )
        print( "@------------------" )

        let contract = StructGasTest()
        var hash: String

        //--------------------------------------------------
        // 各種更新メソッドを読んでみる
        //--------------------------------------------------
        let total = try contract.getTotalStruct( self.helper )
        print( "@ getTotalStruct:", total! )
        
        let target = BigUInt( total! - 1 )
        let structData = try contract.arrStruct( self.helper, id:target )
        print( "@ arrStruct(\(target)):", structData  )

        // test uint160 -> address
        let strAddr = self.helper.getCurEthereumAddress()!
        var val160 = BigUInt( strAddr.suffix(40), radix:16)
        let balance = try contract.getBalanceWithUint160( self.helper, val160:val160! );
        print( "@ getBalanceWithUint160:", balance! )

        // test address -> uint160
        let curAddr = self.helper.getCurAddress()
        val160 = try contract.div256WithAddress( self.helper, addr160:curAddr! )
        print( "@ div256WithAddress:", bi2HexString( val160!, 40 ) )
        
        // update address
        hash = try contract.updateAddress( self.helper, password:self.password, id:target, addr160:curAddr! )
        print( "@ updateAddress:", hash )

        // update uint160
        hash = try contract.updateUint160( self.helper, password:self.password, id:target, val160:val160! )
        print( "@ updateUint160:", hash )

        // create struct
        let val256 = BigUInt( 256 + 19*total! )
        hash = try contract.createStruct( self.helper, password:self.password, val256:val256 )
        print( "@ createStruct:", hash )

        // update direct
        let val8 = UInt8( 8 + 7*total! )
        hash = try contract.updateDirectUint8( self.helper, password:self.password, id:target, val8:val8 )
        print( "@ updateDirectUint8:", hash )
        
        hash = try contract.updateDirectUint256( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateDirectUint256:", hash )

        hash = try contract.updateDirectAll( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateDirectAll:", hash )

        // via strorage
        hash = try contract.updateViaStorageUint8( self.helper, password:self.password, id:target, val8:val8 )
        print( "@ updateViaStorageUint8:", hash )
        
        hash = try contract.updateViaStorageUint256( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaStorageUint256:", hash )

        hash = try contract.updateViaStorageAll( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaStorageAll:", hash )

        // via memory
        hash = try contract.updateViaMemoryUint8( self.helper, password:self.password, id:target, val8:val8 )
        print( "@ updateViaMemoryUint8:", hash )
        
        hash = try contract.updateViaMemoryUint256( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaMemoryUint256:", hash )

        hash = try contract.updateViaMemoryAll( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaMemoryAll:", hash )

        // carelessly
        hash = try contract.updateCarelesslyAll( self.helper, password:self.password, id:target )
        print( "@ updateCarelesslyAll:", hash )
    }
    
    //--------------------------
    // 構造体の更新確認２
    //--------------------------
    func checkUpdate2() throws{
        print( "@------------------" )
        print( "@ checkUpdate2" )
        print( "@------------------" )

        let contract = StructGasTest2()
        var hash: String

        //--------------------------------------------------
        // 各種更新メソッドを読んでみる
        //--------------------------------------------------
        let total = try contract.getTotalStruct( self.helper )
        print( "@ getTotalStruct:", total! )
        
        let target = BigUInt( total! - 1 )
        let structData = try contract.arrStruct( self.helper, id:target )
        print( "@ arrStruct(\(target)):", structData  )

        // create struct
        let val256 = BigUInt( 256 + 19*total! )
        hash = try contract.createStruct( self.helper, password:self.password, val256:val256 )
        print( "@ createStruct:", hash )

        // update direct
        hash = try contract.updateDirect( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateDirect:", hash )

        // via strorage
        hash = try contract.updateViaStorage( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaStorage:", hash )

        // via memory
        hash = try contract.updateViaMemory( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaMemory:", hash )
    }
    
    //--------------------------
    // 構造体の更新確認３
    //--------------------------
    func checkUpdate3() throws{
        print( "@------------------" )
        print( "@ checkUpdate3" )
        print( "@------------------" )

        let contract = StructGasTest3()
        var hash: String

        //--------------------------------------------------
        // 各種更新メソッドを読んでみる
        //--------------------------------------------------
        let total = try contract.getTotalStruct( self.helper )
        print( "@ getTotalStruct:", total! )
        
        let target = BigUInt( total! - 1 )
        let structData = try contract.arrStruct( self.helper, id:target )
        print( "@ arrStruct(\(target)):", structData  )

        // create struct
        let val256 = BigUInt( 256 + 19*total! )
        hash = try contract.createStruct( self.helper, password:self.password, val256:val256 )
        print( "@ createStruct:", hash )

        // update direct
        hash = try contract.updateDirect( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateDirect:", hash )

        // via strorage
        hash = try contract.updateViaStorage( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaStorage:", hash )

        // via memory
        hash = try contract.updateViaMemory( self.helper, password:self.password, id:target, val256:val256 )
        print( "@ updateViaMemory:", hash )
    }
}
