puts "destroying users"
User.destroy_all
puts "user destroyed"

puts "creating seeds"
"----------------------"

# Create 4 users
users = []
4.times do |i|
  user = User.create!(
    first_name: "User#{i+1}",
    last_name: "Lastname#{i+1}",
    email: "user#{i+1}@example.com",
    password: "password"
  )
  users << user
end
puts "created 4 users"


# Create partnerships
puts "creating Partnerships"
Partnership.create(user: User.first, partner: User.second)
Partnership.create(user: User.second, partner: User.first)
Partnership.create(user: User.third, partner: User.fourth)
Partnership.create(user: User.fourth, partner: User.third)
puts "created Partnerships"


# Create categories for each user
categories = []
users.each do |user|
  income_categories = []
  expense_categories = []
  3.times do |i|
    income_categories << Category.create!(
      name: "Income#{i+1}",
      category_type: "Income",
      user: user
    )
  end
  7.times do |i|
    expense_categories << Category.create!(
      name: "Expense#{i+1}",
      category_type: "Expense",
      user: user
    )
  end

  categories << income_categories + expense_categories
end
puts "created income and expense categories for each users"

# Create wallets for each user
wallets = []
users.each do |user|
  2.times do |i|
    wallets << Wallet.create!(
      name: "Debit Wallet #{i+1}",
      wallet_type: "Debit",
      description: "Debit wallet #{i+1} for #{user.first_name}",
      user: user
    )
    wallets << Wallet.create!(
      name: "Credit Wallet #{i+1}",
      wallet_type: "Credit",
      description: "Credit wallet #{i+1} for #{user.first_name}",
      user: user
    )
  end
end
puts "created debit and credit wallets for each users"


# Create transactions for each user
transactions = []
users.each do |user|
  categories_for_user = categories[users.index(user)]
  wallets_for_user = wallets.select { |wallet| wallet.user == user }

  10.times do |i|
    # Create income transactions
    income_category = categories_for_user.select { |category| category.category_type == "Income" }.sample
    income_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "Debit" }.sample.id
    transactions << Transaction.create!(
      description: "Income transaction #{i+1}",
      txn_type: "Income",
      user: user,
      category: income_category,
      amount: rand(100..1000),
      date: Date.today - rand(1..30).days,
      main_wallet_id: income_wallet
    )

    # Create expense transactions
    expense_category = categories_for_user.select { |category| category.category_type == "Expense" }.sample
    expense_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "Credit" }.sample.id
    transactions << Transaction.create!(
      description: "Expense transaction #{i+1}",
      txn_type: "Expense",
      user: user,
      category: expense_category,
      amount: rand(10..100),
      date: Date.today - rand(1..30).days,
      main_wallet_id: expense_wallet
    )

    # Create transfer transactions
    transfer_wallet_from = wallets_for_user.sample.id
    transfer_wallet_to = (wallets_for_user - [transfer_wallet_from]).sample.id
    transactions << Transaction.create!(
      description: "Transfer transaction #{i+1}",
      txn_type: "Transfer",
      user: user,
      amount: rand(10..100),
      date: Date.today - rand(1..30).days,
      main_wallet_id: transfer_wallet_from,
      second_wallet_id: transfer_wallet_to
    )
  end
end
puts "created income, expense, transfer transactions for each users"


# Create budgets for each user
User.all.each do |user|
  3.times do |i|
    budget = Budget.create!(
      name: "Budget #{i+1}",
      amount: rand(500..1000),
      user: user
    )

    # Add multiple categories to each budget
    categories = Category.where(user: user, category_type: 'expense').limit(5).order('RANDOM()')
    budget.categories << categories
  end
end
puts "created budgets each users"
