//
//  StructSampleBasic.swift
//  SolidityStructTest
//
//  Created by 飯田白米 on 2020/03/11.
//  Copyright © 2020 飯田白米. All rights reserved.
//

import Foundation
import UIKit
import BigInt
import web3swift

//-------------------------------------------------------------
// [StructSampleBasic.sol]
//-------------------------------------------------------------
class StructSampleBasic {
    //--------------------------------
    // [abi]ファイルの内容
    //--------------------------------
    internal let abiString = """
[
  {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "getStructAsWords",
    "outputs": [
      {
        "name": "word0",
        "type": "uint256"
      },
      {
        "name": "word1",
        "type": "uint256"
      },
      {
        "name": "word2",
        "type": "uint256"
      },
      {
        "name": "word3",
        "type": "uint256"
      },
      {
        "name": "word4",
        "type": "uint256"
      },
      {
        "name": "word5",
        "type": "uint256"
      },
      {
        "name": "word6",
        "type": "uint256"
      },
      {
        "name": "word7",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]
"""

    //--------------------------------
    // コントラクトの取得
    //--------------------------------
    internal func getContract( _ helper:Web3Helper ) -> web3.web3contract? {
        var address:String
        
        // FIXME ご自身がデプロイしたコントラクトのアドレスに置き換えてください
        // メモ：[rinkeby]のアドレスは実際に存在するコントラクトなので、そのままでも利用できます
        switch helper.getCurTarget()! {
        case Web3Helper.target.mainnet:
            address = ""
            
        case Web3Helper.target.ropsten:
            address = ""

        case Web3Helper.target.kovan:
            address = ""

        case Web3Helper.target.rinkeby:
            address = "0xdde63b0ad4d996d4a144d789a4a5c423dcb60c4e"
        }
        
        let contractAddress = EthereumAddress( address )
        
        let web3 = helper.getWeb3()
        
        let contract = web3!.contract( abiString, at: contractAddress, abiVersion: 2 )
        
        return contract
    }
    
    //---------------------------------------------------
    // getStructAsWords
    //---------------------------------------------------
    public func getStructAsWords( _ helper:Web3Helper ) throws -> [BigUInt]{
        let contract = getContract( helper )
        let tx = contract!.read( "getStructAsWords" )
        let response = try tx!.callPromise().wait()
        
        var arr : [BigUInt] = []
        arr.append( response["0"] as! BigUInt );
        arr.append( response["1"] as! BigUInt );
        arr.append( response["2"] as! BigUInt );
        arr.append( response["3"] as! BigUInt );
        arr.append( response["4"] as! BigUInt );
        arr.append( response["5"] as! BigUInt );
        arr.append( response["6"] as! BigUInt );
        arr.append( response["7"] as! BigUInt );

        return arr
    }
}
