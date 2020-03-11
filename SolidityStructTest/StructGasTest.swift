//
//  StructGasTest.swift
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
// [StructGasTest.sol]
//-------------------------------------------------------------
class StructGasTest {
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
        "internalType": "uint256",
        "name": "val256",
        "type": "uint256"
      },
      {
        "internalType": "uint160",
        "name": "val160",
        "type": "uint160"
      },
      {
        "internalType": "uint64",
        "name": "val64",
        "type": "uint64"
      },
      {
        "internalType": "uint32",
        "name": "val32",
        "type": "uint32"
      },
      {
        "internalType": "address",
        "name": "addr160",
        "type": "address"
      },
      {
        "internalType": "uint16",
        "name": "val16",
        "type": "uint16"
      },
      {
        "internalType": "uint8",
        "name": "val8",
        "type": "uint8"
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
        "internalType": "address",
        "name": "_addr160",
        "type": "address"
      }
    ],
    "name": "updateAddress",
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
        "internalType": "uint160",
        "name": "_val160",
        "type": "uint160"
      }
    ],
    "name": "updateUint160",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "internalType": "uint160",
        "name": "_val160",
        "type": "uint160"
      }
    ],
    "name": "getBalanceWithUint160",
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
    "constant": true,
    "inputs": [
      {
        "internalType": "address",
        "name": "_addr160",
        "type": "address"
      }
    ],
    "name": "div256WithAddress",
    "outputs": [
      {
        "internalType": "uint160",
        "name": "",
        "type": "uint160"
      }
    ],
    "payable": false,
    "stateMutability": "pure",
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
        "internalType": "uint8",
        "name": "_val8",
        "type": "uint8"
      }
    ],
    "name": "updateDirectUint8",
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
    "name": "updateDirectUint256",
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
    "name": "updateDirectAll",
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
        "internalType": "uint8",
        "name": "_val8",
        "type": "uint8"
      }
    ],
    "name": "updateViaStorageUint8",
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
    "name": "updateViaStorageUint256",
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
    "name": "updateViaStorageAll",
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
        "internalType": "uint8",
        "name": "_val8",
        "type": "uint8"
      }
    ],
    "name": "updateViaMemoryUint8",
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
    "name": "updateViaMemoryUint256",
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
    "name": "updateViaMemoryAll",
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
      }
    ],
    "name": "updateCarelesslyAll",
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
            address = "0xEe31Bc2D16928a411952bCee1b77e31348D5489c"
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
    // updateAddress
    //---------------------------------------------------
    public func updateAddress( _ helper:Web3Helper, password:String, id:BigUInt, addr160:EthereumAddress ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, addr160] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateAddress", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()
        
        return response.hash
    }

    //---------------------------------------------------
    // updateUint160
    //---------------------------------------------------
    public func updateUint160( _ helper:Web3Helper, password:String, id:BigUInt, val160:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val160] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateUint160", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()
        
        return response.hash
    }
        
    //---------------------------------------------------
    // getBalanceWithUint160
    //---------------------------------------------------
    public func getBalanceWithUint160( _ helper:Web3Helper, val160:BigUInt ) throws -> BigUInt?{
        let contract = getContract( helper )

        let parameters = [val160] as [AnyObject]
        let tx = contract!.read( "getBalanceWithUint160", parameters:parameters )
        let response = try tx!.callPromise().wait()
        
        // [val160]をアドレスにみたてた上で残高を返す
        return response["0"] as? BigUInt
    }

    //---------------------------------------------------
    // div256WithAddress
    //---------------------------------------------------
    public func div256WithAddress( _ helper:Web3Helper, addr160:EthereumAddress ) throws -> BigUInt?{
        let contract = getContract( helper )

        let parameters = [addr160] as [AnyObject]
        let tx = contract!.read( "div256WithAddress", parameters:parameters )
        let response = try tx!.callPromise().wait()
        
        // [addr160]を数字にみたてた上で２５６で割った値が返る
        return response["0"] as? BigUInt
    }

    //---------------------------------------------------
    // updateDirect
    //---------------------------------------------------
    // Uint8
    public func updateDirectUint8( _ helper:Web3Helper, password:String, id:BigUInt, val8:UInt8 ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val8] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateDirectUint8", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // Uint256
    public func updateDirectUint256( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateDirectUint256", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // All
    public func updateDirectAll( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateDirectAll", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    //---------------------------------------------------
    // updateViaStorage
    //---------------------------------------------------
    // Uint8
    public func updateViaStorageUint8( _ helper:Web3Helper, password:String, id:BigUInt, val8:UInt8 ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val8] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaStorageUint8", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // Uint256
    public func updateViaStorageUint256( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaStorageUint256", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // All
    public func updateViaStorageAll( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaStorageAll", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    //---------------------------------------------------
    // updateViaMemory
    //---------------------------------------------------
    // Uint8
    public func updateViaMemoryUint8( _ helper:Web3Helper, password:String, id:BigUInt, val8:UInt8 ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val8] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaMemoryUint8", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // Uint256
    public func updateViaMemoryUint256( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaMemoryUint256", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    // All
    public func updateViaMemoryAll( _ helper:Web3Helper, password:String, id:BigUInt, val256:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id, val256] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateViaMemoryAll", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }

    //---------------------------------------------------
    // updateCarelesslyAll
    //---------------------------------------------------
    public func updateCarelesslyAll( _ helper:Web3Helper, password:String, id:BigUInt ) throws -> String{
        let contract = getContract( helper )
        
        let parameters = [id] as [AnyObject]
        let data = Data()
        var options = TransactionOptions.defaultOptions
        options.from = helper.getCurAddress()
        let tx = contract!.write( "updateCarelesslyAll", parameters:parameters, extraData:data, transactionOptions:options )
        let response = try tx!.sendPromise( password: password ).wait()

        return response.hash
    }
}
