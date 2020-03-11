//
//  StructGasTest2.swift
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
// [StructGasTest2.sol]
//-------------------------------------------------------------
class StructGasTest2 {
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
    "inputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "name": "arrStruct",
    "outputs": [
      {
        "internalType": "uint32",
        "name": "rscId",
        "type": "uint32"
      },
      {
        "internalType": "uint16",
        "name": "hp",
        "type": "uint16"
      },
      {
        "internalType": "uint16",
        "name": "mp",
        "type": "uint16"
      },
      {
        "internalType": "uint16",
        "name": "attack",
        "type": "uint16"
      },
      {
        "internalType": "uint16",
        "name": "guard",
        "type": "uint16"
      },
      {
        "internalType": "uint16",
        "name": "speed",
        "type": "uint16"
      },
      {
        "internalType": "uint16",
        "name": "luck",
        "type": "uint16"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "getTotalStruct",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_val256",
        "type": "uint256"
      }
    ],
    "name": "createStruct",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_at",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_val256",
        "type": "uint256"
      }
    ],
    "name": "updateDirect",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_at",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_val256",
        "type": "uint256"
      }
    ],
    "name": "updateViaStorage",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_at",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_val256",
        "type": "uint256"
      }
    ],
    "name": "updateViaMemory",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
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
            address = "0x4Cb0859720b45270253E729f4e659735d932629a"
        }
        
        let contractAddress = EthereumAddress( address )
        
        let web3 = helper.getWeb3()
        
        let contract = web3!.contract( abiString, at: contractAddress, abiVersion: 2 )
        
        return contract
    }
    
    //---------------------------------------------------
    // arrStruct
    //---------------------------------------------------
    public func arrStruct( _ helper:Web3Helper, id:BigUInt ) throws -> [String:Any]{
        let contract = getContract( helper )
        
        let parameters = [id] as [AnyObject]
        let tx = contract!.read( "arrStruct", parameters:parameters )
        let response = try tx!.callPromise().wait()
        
        return response
    }

    //---------------------------------------------------
    // getTotalStruct
    //---------------------------------------------------
    public func getTotalStruct( _ helper:Web3Helper ) throws -> BigUInt?{
        let contract = getContract( helper )

        let tx = contract!.read( "getTotalStruct" )
        let response = try tx!.callPromise().wait()
        
        return response["0"] as? BigUInt
    }
    
    //---------------------------------------------------
    // createStruct
    //---------------------------------------------------
    public func createStruct( _ helper:Web3Helper, password:String, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "createStruct", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()
        
        return response.hash
    }
    
    //---------------------------------------------------
    // updateDirect
    //---------------------------------------------------
    public func updateDirect( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateDirect", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    //---------------------------------------------------
    // updateViaStorage
    //---------------------------------------------------
    public func updateViaStorage( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaStorage", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    //---------------------------------------------------
    // updateViaMemory
    //---------------------------------------------------
    public func updateViaMemory( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaMemory", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }
}
