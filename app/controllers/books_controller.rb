class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @author = Author.find(params[:book][:author_id])
    @book = @author.books.create(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title,:isbn)
  end
end
