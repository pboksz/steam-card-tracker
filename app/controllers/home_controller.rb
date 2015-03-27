class HomeController < ApplicationController
  def index
    render :index
  end

  def sitemap
    render :sitemap, layout: false
  end
end
