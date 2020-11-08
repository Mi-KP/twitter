class UsersController < ApplicationController
    before_action :authenticate_user,{only: [:index, :logout, :show, :like]}
    before_action :ensure_correct_user,{only: [:edit, :update]}
    def index
        @user = User.all.order(id: :desc)
    end

    def show
        @user = User.find_by(id:params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(
            name:params[:name],
            email:params[:email],
            image_name:"default_user.jpg",
            password: params[:password]
        )
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "ユーザーを登録しました"
            redirect_to("/users/index")
        else
            flash[:notice] = @user.errors.full_messages
            render("/users/new")
        end
    end

    def edit
        @users = User.find_by(id:params[:id])
    end

    def update
        @users = User.find_by(id:params[:id])
        @users.name = params[:name]
        @users.email = params[:email]
        if params[:image]
        @users.image_name = "#{@users.id}.jpg"
        image = params[:image]
        File.binwrite("public/user_images/#{@users.image_name}",image.read)
        end
        if @users.save
            flash[:notice] = "ユーザー情報が変更されました"
            
            redirect_to("/users/#{@users.id}")
        else
            flash[:notice] = @users.errors.full_messages
            render("/users/edit")
        end
    end

    def destroy
        @users = User.find_by(id:params[:id])
        @users.destroy
        flash[:notice] = "ユーザー情報が削除されました"
        redirect_to("/users/index")
    end

    def login_form
        @user = User.new
    end

    def login
        @user = User.find_by(email:params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id]=@user.id
            flash[:notice] = "ログインに成功しました"
            redirect_to("/users/index")
        else
            @user = User.new(email:params[:email],password:params[:password])
            @error_messages = "メールアドレスまたはパスワードが間違っています"
            render("/users/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end

    def ensure_correct_user
        if @current_user.id != params[:id].to_i
            flash[:notice] = "権限がありません"
            redirect_to("/posts/index")
        end
    end

    def like
        @user = User.find_by(id: params[:id])
    end
end
