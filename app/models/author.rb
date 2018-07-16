class Author < ApplicationRecord
  belongs_to :user

  # アップロードファイルの妥当性をfile_invalid?メソッドで検証
  validate :file_invalid?

  # 書き込み専用のdataプロパティ(UploadedFileオブジェクト)を定義
  def data=(data)
      self.ctype = data.content_type #ctypeプロパティにコンテンツタイプをセット
      self.photo = data.read #photoプロパティにファイル本体をセット
  end

  # アップロードファイルの妥当性を検証するfile_invalid?メソッドを定義
  private
    def file_invalid?
        ps = ['image/jpeg', 'image/gif', 'image/png']
        errors.add(:photo, 'は画像ファイルではありません。') if !ps.include?(self.ctype)
        errors.add(:photo, 'のサイズが1 MBを超えています。') if self.photo.length > 1.megabyte
    end
end
