class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end
  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
       flash[:notice] = "他のユーザー投稿は編集できません"
       redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
      flash[:notice] = "successfully 更新に成功しました"
      redirect_to user_path(current_user.id)
    else
       render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
