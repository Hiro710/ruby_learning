# symbolオブジェクトは変更不可、同じ表記であれば同じオブジェクトIDとなるため必ず同値
# symbolオブジェクトは「名前」を表すものと考えればよい
# rubyでは多くのメソッドで「名前」を指定する場合に、symbolオブジェクトを渡すことができる
p a = :foo                  #=> :foo
p a.object_id               #=> 989468
p b = :foo                  #=> :foo
p b.object_id               #=> 989468

# 定義済みのsymbolオブジェクトを取得する(Symbol.all_symbols)
p :foo                      #=> :foo
p Symbol.all_symbols        #=> [:freeze, :inspect, :intern,...(省略)]

# symbolオブジェクトに対応する文字列を取得する(id2name, to_s)
p :foo.to_s                 #=> "foo"
p :foo.id2name              #=> "foo"