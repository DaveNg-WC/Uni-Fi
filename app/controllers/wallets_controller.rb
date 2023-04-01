class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show edit update destroy ]

  # GET /wallets or /wallets.json
  def index
    # @wallets = Wallet.all
    # raise
    @wallets = Wallet.where(user: current_user, is_hidden: false)
    # @net_worth = 0
    # @wallets.each do |wallet|
    #   balance(wallet)
    #   if wallet.wallet_type == "Debit"
    #     @net_worth += balance(wallet)
    #   else
    #     @net_worth -= balance(wallet)
    #   end
    # end
  end


  # GET /wallets/1 or /wallets/1.json
  # def show
  # end

  # GET /wallets/new
  def new
    @wallet = Wallet.new
  end

  # GET /wallets/1/edit
  def edit
  end

  # POST /wallets or /wallets.json
  def create
    # raise
    @wallet = Wallet.new(wallet_params)
    @wallet.user = current_user

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully created." }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully updated." }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @transactions = Transaction.all
    @transactions = @transactions.where(main_wallet_id: @wallet.id)
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    @wallet.is_hidden = true
    @wallet.save
    # respond_to do |format|
    #   format.html { redirect_to wallets_url, notice: "Wallet was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  # def balance(wallet)
  #   @transactions = Transaction.all
  #   @transactions = @transactions.where(main_wallet_id: wallet.id)
  #   @balance = 0
  #   @transactions.each do |t|
  #     @balance += t.amount
  #   end
  #   @balance
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:name, :wallet_type, :description, :payment_due_date, :is_hidden)
    end
end
