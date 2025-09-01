
module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    # GET /admin/users
    def index
      @users = User.all.order(created_at: :desc)
    end

    # GET /admin/users/new
    def new
      @user = User.new
    end

    # POST /admin/users
    def create
      @user = User.new(user_params)

      # ⚠️ Devise nécessite un mot de passe lors de la création
      if @user.password.blank?
        @user.password = SecureRandom.hex(8) # Génère un mot de passe par défaut si vide
      end

      if @user.save
        redirect_to admin_users_path, notice: "L'utilisateur a été créé avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/users/:id/edit
    def edit
    end

    # PATCH/PUT /admin/users/:id
    def update
      # ⚠️ Si mot de passe vide, on ne le met pas à jour (sinon Devise plante)
      if params[:user][:password].blank?
        if @user.update(user_params.except(:password, :password_confirmation))
          redirect_to admin_users_path, notice: "Les modifications ont été enregistrées avec succès."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        if @user.update(user_params)
          redirect_to admin_users_path, notice: "Les modifications ont été enregistrées avec succès."
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

    # DELETE /admin/users/:id
    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: "L'utilisateur a été supprimé avec succès."
      else
        redirect_to admin_users_path, alert: "Impossible de supprimer cet utilisateur."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    # Strong parameters pour sécuriser les champs
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :role,
        :department_id,
        :phone,
        :address,
        :birth_date,
        :hire_date,
        :password,
        :password_confirmation
      )
    end
  end
end
