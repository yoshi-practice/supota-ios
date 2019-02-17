# supota-ios

## クローン

```:bash
$ git clone https://github.com/supota/supota-ios.git
```



## インストール

アプリで使用するライブラリは`Carthage`と`CocoaPods`で管理しています。

これらをインストールしていない場合は以下に沿ってインストールしてください。

### Carthageのインストール

```:bash
$ brew install carthage
```

### CocoaPodsのインストール

```:bash
$ brew install cocoapods
$ pod setup
```

`Carthage`と`CocoaPods`のインストールが完了したら、プロジェクトのルートディレクトリに移動して以下を実行してください。

```:bash
$ carthage bootstrap --platform iOS
$ pod install
```

以上が終わると`supota.xcworkspace`ファイルが生成されるので、**`supota.xcodeproj`ではなく`supota.xcworkspace`を**開いてビルドしてください。

