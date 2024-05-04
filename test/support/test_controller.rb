class TestController < ActionController::Base
  def new; end
  def create; end
  def show; end
  def edit; end
  

  private

  def default_render
    render plain: "#{params[:controller]}##{params[:action]}"
  end
end
