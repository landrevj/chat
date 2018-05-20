class PagesController < ApplicationController
  def home
    @boards = Board.all.order(abbreviation: :asc)
    @colors = ['#87AF5F', '#E0E07E', '#DC7C54', '#D05353', '#D66799', '#9F5ED1', '#7B53DF', '#4B76D5', '#4CB1DC', '#4CDCCF'].shuffle
    @options = {
      line: {
        animation: {
          duration: 200,
          easing: 'easeInOutCubic',
        },
        tooltips: {
          mode: 'index',
          position: 'average',
          intersect: false,
          displayColors: true,
        },
        legend: {
          position: 'bottom',
        },
      },
      donut: {
        animation: {
          duration: 500,
          easing: 'easeInOutCubic',
        },
      },
      bar: {
        animation: {
          duration: 200,
          easing: 'easeInOutCubic',
        },
        tooltips: {
          mode: 'index',
          position: 'average',
          intersect: false,
          displayColors: true,
        },
      },
    }

    render template: "pages/#{params[:page]}"
  end

  def show
    render template: "pages/#{params[:page]}"
  end
end


