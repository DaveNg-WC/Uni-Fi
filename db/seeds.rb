# puts "clearing data"
# User.destroy_all

# puts "creating seeds"


# # Create 4 users
# puts "creating users"

# user1 = User.create!(first_name: "dave", last_name: "ng", email: "dave@gmail.com", password: "123456")
# user2 = User.create!(first_name: "yx", last_name: "lee", email: "yx@gmail.com", password: "123456")
# user3 = User.create!(first_name: "Ezekiel", last_name: "lee", email: "elyf@gmail.com", password: "123456")
# user4 = User.create!(first_name: "TX", last_name: "Tang", email: "tx@gmail.com", password: "123456")

# users = [user1, user2, user3, user4]
# puts "users created"

# # Create categories for each user
# puts "creating category for user"
# users.each do |user|
#   3.times do |i|
#     user.categories << Category.create!(
#       name: "Income#{i+1}",
#       category_type: "income",
#       user: user
#     )
#   end
#   7.times do |i|
#     user.categories << Category.create!(
#       name: "Expense#{i+1}",
#       category_type: "expense",
#       user: user
#     )
#   end
# end
# puts "created category for user "

# # Create wallets for each user
# puts "creating wallets for user "
# wallets = []
# users.each do |user|
#   2.times do |i|
#     user.wallets << Wallet.create!(
#       name: "Debit Wallet #{i+1}",
#       wallet_type: "debit",
#       description: "Debit wallet #{i+1} for #{user.first_name}",
#       user: user
#     )
#     user.wallets << Wallet.create!(
#       name: "Credit Wallet #{i+1}",
#       wallet_type: "credit",
#       description: "Credit wallet #{i+1} for #{user.first_name}",
#       user: user
#     )
#   end
# end

# # Create transactions for each user
# transactions = []
# users.each do |user|
#   categories_for_user = categories[users.index(user)]
#   wallets_for_user = wallets.select { |wallet| wallet.user == user }

#   10.times do |i|
#     # Create income transactions
#     income_category = categories_for_user.select { |category| category.category_type == "income" }.sample
#     income_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "debit" }.sample
#     transactions << Transaction.create!(
#       description: "Income transaction #{i+1}",
#       txn_type: "income",
#       user: user,
#       category: income_category,
#       amount: rand(100..1000),
#       date: Date.today - rand(1..30).days,
#       main_wallet: income_wallet
#     )

#     # Create expense transactions
#     expense_category = categories_for_user.select { |category| category.category_type == "expense" }.sample
#     expense_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "credit" }.sample
#     transactions << Transaction.create!(
#       description: "Expense transaction #{i+1}",
#       txn_type: "expense",
#       user: user,
#       category: expense_category,
#       amount: rand(10..100),
#       date: Date.today - rand(1..30).days,
#       main_wallet: expense_wallet
#     )

#     # Create transfer transactions
#     transfer_wallet_from = wallets_for_user.sample
#     transfer_wallet_to = (wallets_for_user - [transfer_wallet_from]).sample
#     transactions << Transaction.create!(
#       description: "Transfer transaction #{i+1}",
#       txn_type: "transfer",
#       user: user,
#       amount: rand(10..100),
#       date: Date.today - rand(1..30).days,
#       main_wallet: transfer_wallet_from,
#       second_wallet: transfer_wallet_to
#     )
#   end
# end

# # Create budgets for each user
# User.all.each do |user|
#   3.times do |i|
#     budget = Budget.create!(
#       name: "Budget #{i+1}",
#       amount: rand(500..1000),
#       user: user
#     )

#     # Add multiple categories to each budget
#     categories = Category.where(user: user, category_type: 'Expense').limit(5).order('RANDOM()')
#     budget.categories << categories
#   end
# end


 puts "clearing data"
 User.destroy_all

 puts "creating seeds"


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

# Create categories for each user
categories = []
users.each do |user|
  income_categories = []
  expense_categories = []
  3.times do |i|
    income_categories << Category.create!(
      name: "Income#{i+1}",
      category_type: "income",
      user: user
    )
  end
  7.times do |i|
    expense_categories << Category.create!(
      name: "Expense#{i+1}",
      category_type: "expense",
      user: user
    )
  end
  categories << income_categories + expense_categories
end

# Create wallets for each user
wallets = []
users.each do |user|
  2.times do |i|
    wallets << Wallet.create!(
      name: "Debit Wallet #{i+1}",
      wallet_type: "debit",
      description: "Debit wallet #{i+1} for #{user.first_name}",
      user: user
    )
    wallets << Wallet.create!(
      name: "Credit Wallet #{i+1}",
      wallet_type: "credit",
      description: "Credit wallet #{i+1} for #{user.first_name}",
      user: user
    )
  end
end

# Create transactions for each user
transactions = []
users.each do |user|
  categories_for_user = categories[users.index(user)]
  wallets_for_user = wallets.select { |wallet| wallet.user == user }

  10.times do |i|
    # Create income transactions
    income_category = categories_for_user.select { |category| category.category_type == "income" }.sample
    income_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "debit" }.sample
    transactions << Transaction.create!(
      description: "Income transaction #{i+1}",
      txn_type: "income",
      user: user,
      category: income_category,
      amount: rand(100..1000),
      date: Date.today - rand(1..30).days,
      main_wallet_id: income_wallet
    )

    # Create expense transactions
    expense_category = categories_for_user.select { |category| category.category_type == "expense" }.sample
    expense_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "credit" }.sample
    transactions << Transaction.create!(
      description: "Expense transaction #{i+1}",
      txn_type: "expense",
      user: user,
      category: expense_category,
      amount: rand(10..100),
      date: Date.today - rand(1..30).days,
      main_wallet_id: expense_wallet
    )

    # Create transfer transactions
    transfer_wallet_from = wallets_for_user.sample
    transfer_wallet_to = (wallets_for_user - [transfer_wallet_from]).sample
    transactions << Transaction.create!(
      description: "Transfer transaction #{i+1}",
      txn_type: "transfer",
      user: user,
      amount: rand(10..100),
      date: Date.today - rand(1..30).days,
      main_wallet_id: transfer_wallet_from,
      second_wallet_id: transfer_wallet_to
    )
  end
end

# Create budgets for each user
User.all.each do |user|
  3.times do |i|
    budget = Budget.create!(
      name: "Budget #{i+1}",
      amount: rand(500..1000),
      user: user
    )

    # Add multiple categories to each budget
    categories = Category.where(user: user, category_type: 'Expense').limit(5).order('RANDOM()')
    budget.categories << categories
  end
end
