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

# rescueはbeginを指定しなくても使える
# ifと同様に修飾子としても書くことができる
# この場合例外が発生すると、rescueで指定された式が実行される

# 1 / 0 rescue p 1      #=> 1

=begin
  メソッドの中で指定した場合もメソッド内部で例外が発生すると、rescue以降を実行する
  def foo
    -1 / 0
  rescue
    p 1
  end

  p foo   #=> 1
=end

=begin
  例外クラスに続いて「=>」で識別子を指定すると、例外オブジェクトを参照できる
  例外オブジェクトは、messageオブジェクトを使用して指定した例外メッセージを、
  backtraceを使用して例外が発生した場所を参照できる

  # 例外オブジェクトの取得
  begin
    1 / 0
  rescue ZeroDivisionError => e
    p e.backtrace
  end
=end

=begin
  同じスレッドとブロックで発生した最後の例外は、組み込み変数「$!」で参照できる
  raiseを引数なしで実行することで、最後に発生した例外を再度発生させることができる
  (例外が発生していない場合、raiseは例外RuntimeErrorを発生する)
  これは責任範囲でやるべきことを行い、残りを呼び出し元に委ねる場合に便利

  # 例外の再発生
  begin
    1 / 0
  rescue ZeroDivisionError
    p $!.class          #=> ZeroDivisionError
    raise               # ZeroDivisionErrorの再発生
  end
=end

=begin
  例外処理を呼び出し元に委ねるのではなく、自分で解決して再度行いたい場合は、retryが便利
  これは、再度beginを実行する、この場合でもensureは1回しか実行されない
  a = 0

  begin
    b = 1 / a
  rescue  ZeroDivisionError
    a += 1
    retry
  ensure
    p b
  end       #=> 1
=end

=begin
  rescueは1つのbeginの中でいくつでも指定できる
  しかし、最初にマッチしたものしか実行されない
  よって、より範囲の狭い例外クラスをあとで指定しても、役に立たない
  rescueを続けて書く場合は、マッチする範囲が広くなる順に指定する様に注意する

  begin
  1 / 0
  rescue
    p 1
  rescue  ZeroDivisionError # この例外処理は実行されない
    p 2
  end                       #=> 1
=end
