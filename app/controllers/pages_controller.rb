class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def menu
  end

  def dashboard
    @outflow_this_month = 0
    current_user.expenses.each do |c|
      @outflow_this_month += c.this_month_balance
    end

    @outflow_last_month = 0
    current_user.expenses.each do |c|
      @outflow_last_month += c.last_month_balance
    end

    @inflow_this_month = 0
    current_user.incomes.each do |c|
      @inflow_this_month += c.month_balance(Time.now.month)
    end


    @net_worth = 0
    current_user.wallets.each do |w|
      if w.wallet_type == "Debit"
        @net_worth += w.balance
      else
        @net_worth -= w.balance
      end
    end

    # ---------------------------------- for charts and graphs  (data can be hash or array)-------------------------------------------------------
    @total_income             = current_user.transactions.where(txn_type: "Income")
    @total_expense            = current_user.transactions.where(txn_type: "Expense")

    # ---------------------- This Week  ------------------------

    ## Calculating each Expense category's balance for the week.
    ## Returns a hash. {cat.name: cat balance} sorted Descending
    @week_spends_breakdown = {}
    last_7_days = (Date.current - 6)..Date.current
    current_user.categories.each do |c|
      # skip if category is income
      next if c.income?

      balance = 0
      c.transactions.where(date: last_7_days).each do |t|
        balance += t.amount
      end
      @week_spends_breakdown.store(c.name, balance)
    end
    @week_spends_breakdown    = @week_spends_breakdown.sort_by { |k, v| -v }.to_h
    @expense_this_week        = @total_expense.where(date: last_7_days)
    @income_this_week         = @total_income.where(date: last_7_days)


    # -------------- This Month  -------------------------
    @month_spends_breakdown = {}
    current_user.categories.each do |c|
      @month_spends_breakdown.store(c.name, c.month_balance(Time.now.month)) if c.expense?
    end
    @month_spends_breakdown   = @month_spends_breakdown.sort_by { |k, v| -v }.to_h

    @expense_this_month       = @total_expense.where(date: Date.current.all_month)
    @income_this_month        = @total_income.where(date: Date.current.all_month)


    @total_income_by_month    = @total_income.group_by_month(:date, format: "%b").sum(:amount)

    # -------------- This Year by months -----------------

    @total_income_this_year   = @total_income.where(date: Date.current.all_year).group_by_month(:date, format: "%b").sum(:amount)
    @total_expense_by_month   = @total_expense.group_by_month(:date, format: "%b").sum(:amount)
    @net_income_by_month      = {}

    @total_income_by_month.each do |month, income|
      expense                     = @total_expense_by_month[month] || 0  # || 0: This is a default value in case the month key is not found
      @net_income_by_month[month] = income - expense
    end
  end
end
