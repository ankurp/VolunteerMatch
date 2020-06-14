class OrganizationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_organization, only: [:show, :edit, :update]
  before_action :is_owner, only: [:edit, :update, :destroy]

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/1/edit
  def edit
  end


  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to '/', notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, organization: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :phone, :email, :logo, location_attributes: [
        :id,
        :street_address,
        :city,
        :state
      ])
    end

    def is_owner
      if @organization.id != current_user.try(:organization).try(:id)
        raise AuthorizationException
      end
    end
end
