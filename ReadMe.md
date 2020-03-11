## はじめに  
**iOS** で **Ethereum** ブロックチェーンへアクセスし、**struct** 型のワード構成の確認と、**storage** 変数経由、**memory** 変数経由等でのブロックチェーン書き込みをするテストアプリです。  

イーサリアムクライアントとして [**web3swift**](https://github.com/matter-labs/web3swift)  ライブラリを利用させていただいております。     

----
## 手順  
### ・**CocoaPods** の準備
　ターミナルを開き下記のコマンドを実行します  
　`$ sudo gem install cocoapods`  

### ・**web3swift** のインストール
　ターミナル上で **SolidityStructTest** フォルダ(※ **Podfile** のある階層)へ移動し、下記のコマンドを実行します  
　`$ pod install`  
　
### ・ワークスペースのビルド
　**SolidityStructTest.xcworkspace** を **Xcode** で開いてビルドします  
　（※間違えて **SolidityStructTest.xcodeproj** のほうを開いてビルドするとエラーになるのでご注意ください）
　
### ・動作確認
　**Xcode** から **iOS** 端末にてアプリを起動し、画面をタップするとテストが実行されます  
　**Xcode** のデバッグログに下記のようなログが表示されるのでソースコードと照らし合わせてご確認下さい

---
> @-----------------------------  
> @ TestSolidityStruct: start...  
> @-----------------------------  
> @------------------  
> @ setTarget  
> @------------------  
> @ target: rinkeby  
> @------------------  
> @ setKeystore  
> @------------------  
> @ loadKeystoreJson: json= {"version":3,"id":"d4dc8b26-1538-42fd-bca6-1ed5096b1860","crypto":{"ciphertext":"4b28bd6a11c7288398cafbeb16156f96059bc2d80b6c361b168a5655466178f8","cipherparams":{"iv":"cb2d001939852b9c7bc2633bfb82cd74"},"kdf":"scrypt","kdfparams":{"r":6,"p":1,"n":4096,"dklen":32,"salt":"30195a9b63483960353f8082120a7db25401a9036d91bc3045f2129fa729459b"},"mac":"956fc906c08f882fc30a36cd0d4a60430999484ee160191528fb7a5e548a9918","cipher":"aes-128-ctr"},"address":"0xf5ae7a0da21a42dfb227d2354d5f45d9b6a04982"}  
> @ loadKeystore: result= true  
> @ CURRENT KEYSTORE  
> @ ethereumAddress: 0xf5aE7a0Da21A42dFB227D2354d5F45D9b6a04982  
> @---------------------  
> @ checkStructBasic  
> @---------------------  
> w[0]: 000000000000000000000000adadadadadadadadadadadadadadadadadadadad  
> w[1]: 2562562562562562562562562562562562562562562562562562562562562562  
> w[2]: 3232323264646464646464641601601601601601601601601601601601601601  
> w[3]: 0000000000000000000000000000000000000000000000000000000000881616  
> w[4]: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff  
> w[5]: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff  
> w[6]: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff  
> w[7]: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff  
> ・・省略・・  
> @ updateViaStorage: 0x39cee88c334d7d20bf9e6c96e9a9e0ab5808515cf01d9552bf3962f23ec81fda  
> @ updateViaMemory: 0x11c32f58e2af134b6445e6f38bc8db9d1f8a91049db43f7b3f30001319a5d3d7  
> @------------------  
> @ checkUpdate3  
> @------------------  
> @ getTotalStruct: 2  
> @ arrStruct(1): ["mp": 275, "hp": 275, "13": 275, "dna5": 275, "5": 275, "rscId": 275, "7": 275, "dna4": 275, "speed": 275, "8": 275, "3": 275, "1": 275, "11": 275, "4": 275, "6": 275, "10": 275, "dnaType": 275, "dna1": 275, "dna0": 275, "dna2": 275, "guard": 275, "9": 275, "2": 275, "dna3": 275, "12": 275, "attack": 275, "luck": 275, "0": 275]  
> @ createStruct: 0xaffda4f1919bc8d176d8f1acc817bd8714e1536f1b37b1fe8f2f1c303cd3701d  
> @ updateDirect: 0x4f05d6b4b6c9a81ab56e8aef63832c3fe18228d6c13ce6e77333fc4112b5edf7  
> @ updateViaStorage: 0x659f5e746c18637dc895893d352196c0a9374c1a7252fa34b851a8b5f166283e  
> @ updateViaMemory: 0x0a55cc4db196ec432c20a711f3052077bd177d0431a8f641943897421edf4637  
> @-----------------------------  
> @ TestSolidityStruct: finished  
> @-----------------------------  

---

## 補足

テスト用のコードが **TestSolidtyStruct.swift**、簡易ヘルパーが **Web3Helper.swift**、 イーサリアム上のコントラクトに対応するコードが、各 **StructXxx.swift**となります。  

その他のソースファイルは **Xcode** の **Game** テンプレートが吐き出したコードそのまんまとなります。ただし、画面タップでテストを呼び出すためのコードが **GameScene.swift** に２行だけ追加してあります。

**sol/StructXxx.sol** が各コントラクトのソースとなります。**Xcode** では利用していません。

テストが開始されると、デフォルトで **Rinkeby** テストネットへ接続します。  

初回の呼び出し時であればアカウントを作成し、その内容をアプリのドキュメント領域に **key.json** の名前で出力します。二度目以降の呼び出し時は **key.json** からアカウント情報を読み込んで利用します。  

コントラクトへの書き込みテストは、対象のアカウントに十分な残高がないとエラーとなります。**Xcode** のログにアカウント情報が表示されるので、適宜、対象のアカウントに送金してテストしてください。
  
----
## メモ
　2020年3月11日の時点で、下記の環境で動作確認を行なっています。  

#### 実装環境
　・**macOS Mojave 10.14.4**  
　・**Xcode 11.3.1(11C504)**

#### 確認端末
　・**iPad**(第六世代) **iOS 12.2**  
