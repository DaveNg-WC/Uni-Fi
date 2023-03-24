class PartnershipsController < ApplicationController
  def index
    if user_signed_in? && current_user.partnership
      @user_partner = User.find(current_user.partnership.partner_id)
      @partnership = current_user.partnership.partner_id
    end
  end

  def new
  end

  def create
    user_partner = User.find(params[:account_id].to_i)

    # IF date of birth matches, allow the below?

    ## creates partnership for current user
    partnership_user = Partnership.new(user_id: current_user.id, partner_id: user_partner.id)
    partnership_user.save

    ## creates partnership for partner
    partnership_partner = Partnership.new(user_id: user_partner.id, partner_id: current_user.id)
    partnership_partner.save

    # This will redirect the user to the main page of partnerships to show that his connection with partner is successful
    redirect_to partnerships_path
  end

  def destroy
    user_partner = User.find(current_user.partnership.partner_id)

    # this destroy's current_user's partnership
    current_user.partnership.destroy

    # this destroy's user_partner's partnership
    user_partner.partnership.destroy
    redirect_to partnerships_path, notice: "Partnership successfully deleted!"
  end
end
