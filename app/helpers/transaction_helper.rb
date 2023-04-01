module TransactionHelper
  def from(t)
    from = t.category.name if t.income?
    from = t.main_wallet.name if t.expense?
    from = t.main_wallet.name if t.transfer?
    return from
  end

  def date(t)
    return t.date
  end

  def to(t)
    to = t.main_wallet.name if t.income?
    to = t.category.name if t.expense?
    to = t.second_wallet.name if t.transfer?
    return to
  end

  def amount(t)
    amount = "-#{t.amount}" if t.expense?
    amount = "#{t.amount}" if t.transfer?
    amount = "#{t.amount}" if t.income?

    return amount
  end
end
