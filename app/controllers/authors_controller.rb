class AuthorsController < ApplicationController
  def new
    @author = Author.new
  end

  def create
    @author = Author.create(author_params)
    if @author.save
      redirect_to @author
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @author = Author.find(params[:id])
  end

  private

  def author_params
    params.require(:author).permit(:name, :dob)
  end
end
