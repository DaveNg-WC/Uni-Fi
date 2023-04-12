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
      net_worth += w.balance
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
      week_spends_breakdown.store(c.name, balance) unless balance.zero?
    end
    week_spends_breakdown    = week_spends_breakdown.sort_by { |k, v| -v }.to_h
  end

  def month_spends_breakdown(user)
    ## Returns a hash. {cat.name: cat balance} sorted Descending
    month_spends_breakdown = {}
    user.categories.each do |c|
      # skip if category is income
      next if c.income?

      balance = 0
      c.transactions.where(date: Date.current.all_month).each do |t|
        balance += t.amount
      end
      month_spends_breakdown.store(c.name, balance) unless balance.zero?
    end
    month_spends_breakdown    = month_spends_breakdown.sort_by { |k, v| -v }.to_h
  end

  def year_spends_breakdown(user)
    ## Returns a hash. {cat.name: cat balance} sorted Descending
    year_spends_breakdown = {}
    user.categories.each do |c|
      # skip if category is income
      next if c.income?

      balance = 0
      c.transactions.where(date: Date.current.all_year).each do |t|
        balance += t.amount
      end
      year_spends_breakdown.store(c.name, balance) unless balance.zero?
    end
    year_spends_breakdown = year_spends_breakdown.sort_by { |k, v| -v }.to_h
  end

  def combined_week_spends_breakdown
    week_spends_breakdown(current_user).merge(week_spends_breakdown(current_user.partner)) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_month_spends_breakdown
    month_spends_breakdown(current_user).merge(month_spends_breakdown(current_user.partner)) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_year_spends_breakdown
    year_spends_breakdown(current_user).merge(year_spends_breakdown(current_user.partner)) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_expense_this_week
    # returns an combined hash
    last_7_days = (Date.current - 6)..Date.current
    user        = total_expense(current_user).where(date: last_7_days).group_by_day(:date).sum(:amount)
    partner     = total_expense(current_user.partner).where(date: last_7_days).group_by_day(:date).sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_expense_this_month_by_week
    # returns an combined hash
    user        = total_expense(current_user).where(date: Date.current.all_month).group_by_week(:date, format: "%-d %b").sum(:amount)
    partner     = total_expense(current_user.partner).where(date: Date.current.all_month).group_by_week(:date, format: "%-d %b").sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_income_this_month
    # returns an combined hash
    user        = total_income(current_user).where(date: Date.current.all_month).group_by_month(:date, format: "%b").sum(:amount)
    partner     = total_income(current_user.partner).where(date: Date.current.all_month).group_by_month(:date, format: "%b").sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_expense_this_month
    # returns an combined hash
    user        = total_expense(current_user).where(date: Date.current.all_month).group_by_month(:date, format: "%b").sum(:amount)
    partner     = total_expense(current_user.partner).where(date: Date.current.all_month).group_by_month(:date, format: "%b").sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_income_this_year
    # returns an combined hash
    user        = total_income(current_user).where(date: Date.current.all_year).group_by_month(:date, format: "%b").sum(:amount)
    partner     = total_income(current_user.partner).where(date: Date.current.all_year).group_by_month(:date, format: "%b").sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_expense_this_year
    # returns an combined hash
    user        = total_expense(current_user).where(date: Date.current.all_year).group_by_month(:date, format: "%b").sum(:amount)
    partner     = total_expense(current_user.partner).where(date: Date.current.all_year).group_by_month(:date, format: "%b").sum(:amount)
    merged_hash = user.merge(partner) do |key, old_value, new_value|
      old_value + new_value
    end
  end

  def combined_net_income_by_month
    #returns hash
    net_income_by_month = {}
    combined_income_this_year.each do |month, income|
      expense                     = combined_expense_this_year[month] || 0  # || 0: This is a default value in case the month key is not found
      net_income_by_month[month] = income - expense
    end
    net_income_by_month
  end

end
