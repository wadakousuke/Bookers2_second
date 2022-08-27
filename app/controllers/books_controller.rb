class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully 新規追加に成功しました"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
