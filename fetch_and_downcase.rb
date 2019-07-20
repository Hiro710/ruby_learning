# ダッグタイピング

def fetch_and_downcase(ary, index)
  if str = ary[index]
    return str.downcase
  end
end

ary =  ["ABC", "DEF", "GHI"]
p fetch_and_downcase(ary, 2) # => "ghi"

# このメソッドに配列ではなくハッシュを渡して以下の様にもできる
hash = {0 => "ABC", 1 => "DEF", 2 => "GHI"}
p fetch_and_downcase(hash, 2) # => "ghi"
