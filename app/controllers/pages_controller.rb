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

    @income_this_month = 0
    current_user.incomes.each do |c|
      @income_this_month += c.month_balance(Time.now.month)
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

    @month_spends_breakdown = {}
    current_user.categories.each do |c|
      @month_spends_breakdown.store(c.name, c.month_balance(Time.now.month)) if c.expense?
    end
    @month_spends_breakdown   = @month_spends_breakdown.sort_by { |k, v| -v }.to_h


    @total_income             = current_user.transactions.where(txn_type: "Income")
    @total_expense            = current_user.transactions.where(txn_type: "Expense")
    @expense_this_week        = @total_expense.where(date: Date.current.all_week).group_by_day_of_week(:date, format: "%a",week_start: :mon).sum(:amount)
    @expense_this_month       = @total_expense.where(date: Date.current.all_month)
    @total_income_by_month    = @total_income.group_by_month(:date, format: "%b").sum(:amount)
    @total_expense_by_month   = @total_expense.group_by_month(:date, format: "%b").sum(:amount)
    @net_income_by_month      = {}

    @total_income_by_month.each do |month, income|
      expense                     = @total_expense_by_month[month] || 0  # || 0: This is a default value in case the month key is not found
      @net_income_by_month[month] = income - expense
    end
  end
end
