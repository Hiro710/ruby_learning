# オブジェクトのID 1
# TrueClass, FalseClass, NilClass, Symbol, Fixnumクラスのインスタンスは
# 同じリテラルであれば同じオブジェクトになるため同じオブジェクトIDになる
a = "foo"
p a.object_id #=> 60
p a.__id__    #=> 60

# オブジェクトのID 2
p "foo".object_id
p "foo".object_id # 上記とは異なるオブジェクトID
p :foo.object_id
p :foo.object_id  # 上記と同じオブジェクトID

# オブジェクトのクラス
p "foo".class #=> String
p :foo.class  #=> Symbol


# オブジェクトの比較 1
a = "foo"
p a.hash
p a.object_id
b = "foo"
p b.hash
p b.object_id
# eql?よりもequal?の方がより厳密な比較となる
p a.eql?(b) #=> true、同じ内容
p a.equal?(b) #=> false、異なるオブジェクト

