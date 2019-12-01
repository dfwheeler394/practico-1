class AccountsController < ApplicationController
  def show
    if params[:query]
      @user = User.find_by(username: params[:query])
    else
      @user = User.find(params[:id])
    end
    skip_authorization
  end

  def friends
    @user = User.find(params[:id])
    skip_authorization
  end

  def request_friend
    friended_user = User.find(params[:id])
    current_user.friend_request(friended_user)
    skip_authorization

    redirect_to account_path(current_user)
  end

  def accept_friend
    friended_user = User.find(params[:id])
    current_user.accept_request(friended_user)
    skip_authorization

    redirect_to account_path(current_user)
  end

  def delete_friend
    unfriended_user = User.find(params[:id])
    current_user.remove_friend(unfriended_user)
    skip_authorization

    redirect_to account_path(current_user)
  end

end
