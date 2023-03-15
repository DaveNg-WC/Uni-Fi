require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "should create transaction" do
    visit transactions_url
    click_on "New transaction"

    fill_in "Amount", with: @transaction.amount
    fill_in "Date", with: @transaction.date
    fill_in "Debit", with: @transaction.debit_id
    fill_in "Description", with: @transaction.description
    fill_in "Expense", with: @transaction.expense_id
    fill_in "Income", with: @transaction.income_id
    fill_in "Type", with: @transaction.type
    fill_in "User", with: @transaction.user_id
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "should update Transaction" do
    visit transaction_url(@transaction)
    click_on "Edit this transaction", match: :first

    fill_in "Amount", with: @transaction.amount
    fill_in "Date", with: @transaction.date
    fill_in "Debit", with: @transaction.debit_id
    fill_in "Description", with: @transaction.description
    fill_in "Expense", with: @transaction.expense_id
    fill_in "Income", with: @transaction.income_id
    fill_in "Type", with: @transaction.type
    fill_in "User", with: @transaction.user_id
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction" do
    visit transaction_url(@transaction)
    click_on "Destroy this transaction", match: :first

    assert_text "Transaction was successfully destroyed"
  end
end
