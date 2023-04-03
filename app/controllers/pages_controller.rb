class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def menu
  end

  def dashboard
    @spends_this_month = 0
    current_user.expenses.each do |c|
      @spends_this_month += c.this_month_balance
    end

    @spends_last_month = 0
    current_user.expenses.each do |c|
      @spends_last_month += c.last_month_balance
    end

    @net_worth = 0
    current_user.wallets.each do |w|
      if w.wallet_type == "Debit"
        @net_worth += w.balance
      else
        @net_worth -= w.balance
      end
    end

    # ---------------------------------- for charts and graphs -------------------------------------------------------
    #  data can be hash or array

    @month_spends_by_category_data = {}
    current_user.categories.each do |c|
      @month_spends_by_category_data.store(c.name, c.month_balance(3)) if c.expense?
    end

    @expense_txn = current_user.transactions.where(txn_type: "expense", date: Date.current.all_week)
  end
end
