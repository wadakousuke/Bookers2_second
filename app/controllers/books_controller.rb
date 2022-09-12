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
    @book = Book.find(params[:id])
  end
  def destroy
    book = Book.find(params[:id])
    if book.user_id == current_user.id
      book.destroy
      redirect_to books_path
    else
      flash[:notice] = "他のユーザー投稿は削除できません"
       render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render :edit
    else
       flash[:notice] = "他のユーザー投稿は編集できません"
       redirect_to books_path
    end
  end
  def update
    book = Book.find(params[:id])
      if book.update(book_params)
         flash[:notice] = "successfully 新規追加に成功しました"
        redirect_to book_path(book.id)
      else
        flash[:notice] = "他のユーザー投稿は編集できません"
         render :edit
      end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
