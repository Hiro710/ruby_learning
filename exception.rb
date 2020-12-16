# 例外処理
# 例外を発生させるにはraiseを使う
# raiseは第1引数に例外クラスまたはそのインスタンスを、第2引数にメッセージを指定できる

# raise ArgumentError, "引数が不正です"                 #=> 引数が不正です (ArgumentError)
# raise ArgumentError.new, "引数が不正です"             #=> 引数が不正です (ArgumentError)

# 例外クラスのコンストラクタではメッセージを指定できる
# メッセージを含む例外オブジェクト
# err = ArgumentError.new("引数が不正です")
# raise err                                           #=> 引数が不正です (ArgumentError)

# 上記2つの引数は省略可能
# 例外クラスのインスタンスのみ、またはメッセージのみを記述してもよい
# 例外クラスのインスタンスを省略した場合は、RuntimeErrorクラスの例外が発生する

# 引数を省略した例外の発生
# raise "実行中にエラーが発生しました"                      #=> 実行中にエラーが発生しました (RuntimeError)

=begin
  Rubyの例外処理は、例外が発生する可能性がある箇所をbeginとendで囲み、その中のrescueという節で記述する
  begin
    1 / 0   # 例外が発生
    p 1
  rescue
    p 0     # ここが実行される
  end       #=> 0
=end

=begin
  rescueに続いてelseを指定することで、例外が発生しなかった時の処理を記述できる
  また、ensureを続けることで、例外の発生に関わらず、必ず実行する処理も記述できる
  begin, rescue, else, ensureの実行順序が重要

  # elseとensure
  begin       # beginは必ず実行される
    p 1
  rescue      # 例外は発生しないのでrescueは実行しない
    p 0
  else        # rescueが実行されないのでelseは実行される
    p 2
  ensure      # ensureは必ず実行される
    p  3
  end         #=> 1, 2, 3
=end

