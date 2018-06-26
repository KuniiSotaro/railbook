module ViewHelper
    # datetime:整形対象の日付時刻値(Timeオブジェクト)
    # type:出力形式(日付時刻:datetime, 日付のみ:date, 時刻のみ:time)
    def format_datetime(datetime, type = :datetime)
        # 引数datetimeがnilの場合は空文字列を返す
        returen '' unless datetime

        # 引数typeの値に応じて対応するフォーマット文字列もセット
        case type
        when :datetime
            format = '%Y年%m月%d日 %H:%M:%S'
        when :date
            format = '%Y年%m月%d日'
        when :time
            format = '%H:%M:%S'
        end

    # 指定されたフォーマットで日付時刻値を整形
    datetime.strftime(format)
    end

    # collection:リストの元となるオブジェクト配列
    # prop:一覧するプロパティ名
    def list_tag(collection, prop)
        # <ul>要素を生成
        content_tag(:ul) do
            collection.each do |element|
                concat content_tag(:li, element.attributes[prop])
            end
        end
    end


    def blockquote_tag(cite, citetext, options = {}, &block)
        # 引数optionに引数citeで指定された引用元URLを追加
        options.merge! cite: cite
        # <blockquote>要素を生成
        quote_tag = content_tag(:blockquote, capture(&block), options)
        # 引用元を表す<p>要素を生成
        p_tag = content_tag(:p) do
            concat '出典：'
            concat content_tag(:cite, citetext)
        end
        # <blockquote>要素と<p>要素とを連結した結果を返す
        quote_tag.concat(p_tag)
    end
end
