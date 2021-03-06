module Spree
  class LocaleController < BaseController
    def set
      if request.referer && request.referer.starts_with?('http://' + request.host)
        session['user_return_to'] = request.referer
      end
      if params[:locale] && I18n.available_locales.map(&:to_s).include?(params[:locale])
        session[:locale] = I18n.locale = params[:locale]
        flash.notice = t(:locale_changed)
      else
        flash[:error] = t(:locale_not_changed)
      end
      redirect_back_or_default(root_path)
    end
  end
end
