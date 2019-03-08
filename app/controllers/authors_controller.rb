class AuthorsController < ApplicationController
  def new
    @author = Author.new
    @books = Book.all
  end

  def create
    @author = Author.create(author_params)
    if params[:books].present?
      params[:books].each do |id|
        @author.books << Book.find(id)
      end
    end
    if @author.save
      redirect_to @author
    else
      render 'new'
    end
  end

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  private

  def author_params
    params.require(:author).permit(:name, :dob)
  end
end
