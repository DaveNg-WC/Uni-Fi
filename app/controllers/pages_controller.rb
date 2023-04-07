class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def landing
  end

  def menu
  end

  def dashboard
    spends_this_month = 0
    current_user.expenses.each do |c|
      spends_this_month += c.this_month_balance
    end
    @spends_this_month = spends_this_month

    spends_last_month = 0
    current_user.expenses.each do |c|
      spends_last_month += c.last_month_balance
    end
    @spends_last_month = spends_last_month

    net_worth = 0
    current_user.wallets.each do |w|
      if w.wallet_type == "Debit"
        net_worth += w.balance
      else
        net_worth -= w.balance
      end
    end
    @net_worth = net_worth


  end
end
