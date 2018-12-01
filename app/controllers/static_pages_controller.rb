class StaticPagesController < ApplicationController
  before_action :create_game!

  def index
    @games = Game.available
  end

  private

  def create_game!
    if Game.available.size.zero?
      Game.create!()
    end
  end
end
