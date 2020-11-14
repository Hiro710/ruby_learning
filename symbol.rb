# symbolオブジェクトは変更不可、同じ表記であれば同じオブジェクトIDとなるため必ず同値
# symbolオブジェクトは「名前」を表すものと考えればよい
# rubyでは多くのメソッドで「名前」を指定する場合に、symbolオブジェクトを渡すことができる
p a = :foo                  #=> :foo
p a.object_id               #=> 989468
p b = :foo                  #=> :foo
p b.object_id               #=> 989468


