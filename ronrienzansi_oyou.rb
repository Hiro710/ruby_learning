# 論理演算子の応用
name = "Ruby" # nameにデフォルト値を設定
if var        # varがnilまたはfalseでなければ
  name = var  # nameにvarを代入
end
# 上記の4行は||を使って次の1行で書くことができる
name = var || "Ruby"


# 変数に配列の先頭要素を代入する場合を考えてみる
# Array#firstメソッドは先頭要素を返す
item = nil          # itemに初期値を設定
if ary              # aryがnilまたはfalseでなければ
  item = ary.first  # aryの先頭要素をitemに代入する
end
# 変数aryがnilの場合、ary.firstメソッド呼び出しを行うとエラーになる
# 上記例ではあらかじめitemにnilを代入した上でaryがnilでない事を確認してからfirstメソッドを呼んでいる
# 上記は&&を使えば以下の様に1行で書くことができる
item = ary && ary.first
# さらに短く、オブジェクト &. メソッド呼び出し とする書き方もある
# 「安全参照演算子」や「nilチェック付きメソッド呼び出し」「ぼっち演算子」という機能で、aryがnilでないときにだけ
# firstメソッドを呼び出す
# aryがnilのときはnilになる
item = ary &. first


# ||の代入演算子
#  varがnilかfalseの場合に限り1を代入する。これは変数にデフォルト値を与える場合の定番の書き方
var ||= 1
