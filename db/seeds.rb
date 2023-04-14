require 'faker'
# require 'date'

puts "destroying users"
User.destroy_all
puts "user destroyed"

puts "creating seeds"
"----------------------"

# Create 4 users
users = []
user1 = User.create!(
  first_name: "Dave",
  last_name: "Ng",
  email: "user1@example.com",
  password: "password"
)
puts "Created #{user1.first_name} #{user1.last_name}"

user2 = User.create!(
  first_name: "Yi",
  last_name: "Xuan",
  email: "user2@example.com",
  password: "password"
)
puts "Created #{user2.first_name} #{user2.last_name}"

users = [user1, user2]


# Create partnerships
puts "creating Partnerships"
Partnership.create(user: User.first, partner: User.second)
Partnership.create(user: User.second, partner: User.first)
Partnership.create(user: User.third, partner: User.fourth)
Partnership.create(user: User.fourth, partner: User.third)
puts "created Partnerships"

income_list = ["Salary", "Cashback", "Dividend", "Refund"]
# Create categories for each user
categories = []
users.each do |user|
  income_categories = []
  expense_categories = []
  income_list.each do |income|
    income_categories << Category.create!(
      name: income,
      category_type: "Income",
      description: "Inflow transactions",
      user: user
    )
  end


  # Do not create any other categories before this as the ID used for upload statement is fixed. If changed, might have bugs
  # Needed Seed for Statement Upload
  expense_categories << Category.create!(
    name: "Transport",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )

  expense_categories << Category.create!(
    name: "Groceries",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )

  expense_categories << Category.create!(
    name: "Food",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )

  expense_categories << Category.create!(
    name: "Leisure",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )

  expense_categories << Category.create!(
    name: "Services",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )

  expense_categories << Category.create!(
    name: "Others",
    category_type: "Expense",
    description: "Outflow transactions",
    user: user
  )


  categories << income_categories + expense_categories
end
puts "created income and expense categories for each users"

# Create wallets for each user
wallets = []
users.each do |user|
  wallets << Wallet.create!(
    name: "DBS Debit",
    wallet_type: "Debit",
    description: "DBS Debit Black Card ",
    user: user
  )
  wallets << Wallet.create!(
    name: "OCBC Credit",
    wallet_type: "Credit",
    description: "OCBC 360 Credit Card White/Red",
    user: user
  )

  wallets << Wallet.create!(
    name: "UOB Debit",
    wallet_type: "Debit",
    description: "UOB Savings Account",
    user: user
  )
end
puts "created debit and credit wallets for each users"


# Create transactions for each user
transactions = []
users.each do |user|
  categories_for_user = categories[users.index(user)]
  wallets_for_user = wallets.select { |wallet| wallet.user == user }
  i = 1
  while i <= 6
    # Create income transactions
    # if i != 2
      categories_for_user.each do |category|
        if category.category_type == "Income"
          # income_category = categories_for_user.select { |category| category.category_type == "Income" }.sample
          income_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "Debit" }.sample.id
          case category.name
          when "Salary"
            transactions << Transaction.create!(
            description: "Monthly Salary #{i+1}",
            txn_type: "Income",
            user: user,
            category: category,
            amount: rand(5000..6000),
            date: Date.today.prev_month(i-1).beginning_of_month,
            main_wallet_id: income_wallet
          )
          when "Cashback"
            transactions << Transaction.create!(
            description: "Cashback #{i+1}",
            txn_type: "Income",
            user: user,
            category: category,
            amount: rand(50..100),
            date: Date.today.prev_month(i-1).beginning_of_month,
            main_wallet_id: income_wallet
          )
          when "Dividend"
            transactions << Transaction.create!(
            description: "Dividend #{i+1}",
            txn_type: "Income",
            user: user,
            category: category,
            amount: rand(100..300),
            date: Date.today.prev_month(i-1).beginning_of_month,
            main_wallet_id: income_wallet
          )
          # when "Refund"
          #   3.times do |t|
          #     transactions << Transaction.create!(
          #     description: "Dividend #{t+1}",
          #     txn_type: "Income",
          #     user: user,
          #     category: category,
          #     amount: rand(50..100),
          #     date: Date.today.prev_month(i-1).end_of_month - rand(1..30).days,
          #     main_wallet_id: income_wallet
          #   )
          #   end
          end
        elsif category.category_type == "Expense"
          # Create expense transactions
          if i != 1
            expense_wallet = wallets_for_user.select { |wallet| wallet.wallet_type == "Credit" }.sample.id
            case category.name
            when "Transport"
              20.times do |t|
                transactions << Transaction.create!(
                  description: "Daily transport spending #{t+1}",
                  txn_type: "Expense",
                  user: user,
                  category: category,
                  amount: rand(5..25),
                  date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                  main_wallet_id: expense_wallet
                )
              end
            when "Groceries"
              15.times do |t|
                transactions << Transaction.create!(
                  description: "Daily groceries spending #{t+1}",
                  txn_type: "Expense",
                  user: user,
                  category: category,
                  amount: rand(5..50),
                  date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                  main_wallet_id: expense_wallet
                )
              end
            when "Food"
              30.times do |t|
                transactions << Transaction.create!(
                  description: "Daily Food spending #{t+1}",
                  txn_type: "Expense",
                  user: user,
                  category: category,
                  amount: rand(10..30)*user.id,
                  date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                  main_wallet_id: expense_wallet
                )
              end
            when "Leisure"
              # if i > 1
                5.times do |t|
                  transactions << Transaction.create!(
                    description: "Leisure spending #{t+1}",
                    txn_type: "Expense",
                    user: user,
                    category: category,
                    amount: rand(100..500)*user.id,
                    date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                    main_wallet_id: expense_wallet
                  )
                end
              # else
              #   9.times do |t|
              #     transactions << Transaction.create!(
              #       description: "Leisure spending #{t+1}",
              #       txn_type: "Expense",
              #       user: user,
              #       category: category,
              #       amount: rand(200..900)*user.id,
              #       date: Date.today.prev_month(i).beginning_of_month + rand(1..12).days,
              #       main_wallet_id: expense_wallet
              #     )
              #   end
              # end
            when "Services"
              4.times do |t|
                transactions << Transaction.create!(
                  description: "Services spending #{t+1}",
                  txn_type: "Expense",
                  user: user,
                  category: category,
                  amount: rand(20..50),
                  date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                  main_wallet_id: expense_wallet
                )
              end
            when "Others"
              10.times do |t|
                transactions << Transaction.create!(
                  description: "Other spending #{t+1}",
                  txn_type: "Expense",
                  user: user,
                  category: category,
                  amount: rand(20..100),
                  date: Date.today.prev_month(i).end_of_month - rand(1..29).days,
                  main_wallet_id: expense_wallet
                )
              end
            end
          end
        end
            # Create transfer transactions
          5.times do |t|
            transfer_wallet_from = wallets_for_user.sample.id
            transfer_wallet_to = (wallets_for_user - [transfer_wallet_from]).sample.id
            transactions << Transaction.create!(
              description: "Transfer transaction #{t+1}",
              txn_type: "Transfer",
              user: user,
              amount: rand(10..100),
              date: Date.today.prev_month(i).end_of_month - rand(1..30).days,
              main_wallet_id: transfer_wallet_from,
              second_wallet_id: transfer_wallet_to
            )
          end
      end
    # end
    i += 1
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
  end

    # Add multiple categories to each budget
    # categories = Category.where(user: user, category_type: 'Expense').limit(5).order('RANDOM()')
    # budget.categories << categories
end

puts "created budgets each users"
