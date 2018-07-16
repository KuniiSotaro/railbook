require 'kconv'
result = ''

# モデルのプロパティ名をカンマ区切りで出力(ヘッダー行)
result << @books.attribute_names.join(',')
result << "\r"

# テーブルの内容を順にカンマ区切りで出力(データ行)
@books.each do |b|
    result << b.attributes.values.join(',')
    result << "\r"
end

# 最終的な結果(戻り値はShift-JIS)
result.kconv(Kconv::SJIS, Kconv::UTF8)
