class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions.order("date DESC")
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction    = Transaction.new
    @expenses       = current_user.categories.where("LOWER(category_type) = ?", "expense")
    @incomes        = current_user.categories.where("LOWER(category_type) = ?", "income")
    @wallets        = current_user.wallets
  end

  # GET /transactions/1/edit
  def edit
    @expenses       = current_user.categories.where("LOWER(category_type) = ?", "expense")
    @incomes        = current_user.categories.where("LOWER(category_type) = ?", "income")
    @wallets        = current_user.wallets
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:description, :txn_type, :category_id, :amount, :date, :main_wallet_id, :second_wallet_id)
    end
end
