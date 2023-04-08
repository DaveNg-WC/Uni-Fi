require "date"


module DashboardHelper

  def outflow_this_month(user)
    # returns integer
    outflow_this_month = 0
    user.expenses.each do |c|
      outflow_this_month += c.this_month_balance
    end

    outflow_this_month
  end

  def outflow_last_month(user)
    # returns integer
    outflow_last_month = 0
    user.expenses.each do |c|
      outflow_last_month += c.last_month_balance
    end
    outflow_last_month
  end

  def inflow_this_month(user)
    # returns integer
    inflow_this_month = 0
    user.incomes.each do |c|
      inflow_this_month += c.month_balance(Time.now.month)
    end
    inflow_this_month
  end

  def net_worth(user)
    #returns integer
    net_worth = 0
    user.wallets.each do |w|
      if w.wallet_type == "Debit"
        net_worth += w.balance
      else
        net_worth -= w.balance
      end
    end
    net_worth
  end

  def total_income(user)
    #return array of instances
    user.transactions.where(txn_type: "Income")
  end

  def total_expense(user)
    #return array of instances
    user.transactions.where(txn_type: "Expense")
  end

  def week_spends_breakdown(user)
    ## Returns a hash. {cat.name: cat balance} sorted Descending
    week_spends_breakdown = {}
    last_7_days = (Date.current - 6)..Date.current
    user.categories.each do |c|
      # skip if category is income
      next if c.income?

      balance = 0
      c.transactions.where(date: last_7_days).each do |t|
        balance += t.amount
      end
      week_spends_breakdown.store(c.name, balance)
    end
    week_spends_breakdown    = week_spends_breakdown.sort_by { |k, v| -v }.to_h
  end

  def combined_expense_this_week
    # returns an combined hash
    last_7_days = (Date.current - 6)..Date.current
    user        = total_expense(current_user).where(date: last_7_days).group_by_day(:date).sum(:amount)
    partner     = total_expense(current_user.partner).where(date: last_7_days).group_by_day(:date).sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
    merged_hash
  end

end
