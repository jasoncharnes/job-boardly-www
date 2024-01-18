class SitemapsController < ApplicationController
  def index
    @pages = Spina::Page.live
  end
end
