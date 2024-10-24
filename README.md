
# Swift　メモ

## SwiftUIとCompose
どちらもコード上でUIを作成する
プレビューしながら作成もできるのでUI用のレイアウトファイルを作成する手間がない
どちらかを抑えておけば、理解が早い

## 最初のセットアップ

var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }

からSwiftUI開始

struct MainScreen: View {
    var body: some View {
        ...
    }
}

大枠のコンポーネントを開始する
個別のコンポーネントもメソッド別に作成可能
Composeと同じように使いまわしたり、小分けにして可読性を上げたりするのは同じ概念

## View周り

## コンテンツを表示するためのパーツ比較（よく使いそうなの
SwiftUI | Compose

・Text | Text
テキストを表示するView

・Button | Button
タップするためのボタン

・Image | Image
画像を表示するためのView

・AsyncImage | （ライブラリ次第）
ネットワークから画像をDLして表示するためのView
Androidは標準で対応できるものがないので、ライブラリを使うのがベター

・VStack | Row
横向きに整列配置する

・ZStack | Box
重ねて整列配置する

・HStack | Column
縦向きに整列配置する

・ScrollView | Row,Box,Column内で設定できる
スクロールするためのView
SwiftUIだと外側にラップした配置にしてScrollViewを置く

・ForEach　| LazyColumn or LazyRow
SwiftUIでforEachは使えないのでForEachでリスト内のアイテムをループさせる
個別のレイアウトは中で作る


## モデルのアーキテクチャ
SwiftUIではMVVMも視野
Composeと（ほぼ同じなので）同じ構成でも理解しやすい

### Viewへデータを反映させる仕組み

ViewModel(それに類するもの)に置いておいたものに変更を検知されたらUIを変更させるようにする

@StateObjectでクラスインスタンスがライフサイクルを超えられるようにする（再描画で値が変化されなくなる）
→クラスオブジェクトにObservableObjectを指定する
→ViewModel向き

@PublishedはObservableObject内で変数が変更されたらSwiftUIが変更を検知してViewを再描画する
→変更のトリガーとして使う
→Composeで言うところのremember / StateFlow & collectAsState

ViewModelに通信処理などのメソッドを置いたりするのはAndroidのMVVMの考え方とほぼ同じ
もちろんMVVM以外の構造もある


## Repositry（通信）周り

### Jsonを受け取るためのクラス（Responseクラス）
structクラスで作る（構造体クラス）でDataClass みたいなもの

レスポンスを受け取るためにCodableプロトコルを準拠させる。（Json構造の文字列のパースに必要）
JsonのKey名とクラス内の変数を別にしたい場合
enum CodingKeys: String, CodingKey
を作ってKeyと変数を結びつけることができる。

### HTTPS通信を行う
URLSessionを使って通信をする
GET/POSTなどのプロトコルを使う場合はURLComponentsを使って通信する（クエリなどもここで一緒に作る）

通信はバックグラウンド通信なので async / awaitで非同期処理を行って実行する
エラーハンドリングのために try await...のような形でリクエストする。

Data型で受け取るのでこのDataをResponseクラスでパースする場合は
JSONDecoder()でResponseクラスでパースする。
（アプリ内で用意されてない変数は基本的に無視）

最終的に上のレスポンスクラスをそのまま返して通信処理終了