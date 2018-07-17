class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :detect_device

  # RecordNotFound例外を処理するのはinvalidメソッド
  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid

  private
    def id_invalid(e)
        # ステータス404(Not Found)で指定ビューを描写
        render 'shared/record_not_found', status: 404
    end

    # クエリ情報typeの値に応じて、request.variantを設定
    def detect_device
        case params[:type]
        when 'mobile'
            request.variant = :mobile
        when 'tablet'
            request.variant = :tablet
        end
    end
end
