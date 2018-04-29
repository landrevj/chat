class PagesController < ApplicationController
  def home
    @boards = Board.all.order(abbreviation: :asc)
    render template: "pages/#{params[:page]}"
  end

  def show
    render template: "pages/#{params[:page]}"
  end
end
