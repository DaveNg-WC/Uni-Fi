class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]

  # GET /budgets
  def index
    @budgets = current_user.budgets.order(:name)
  end

  # GET /budgets/1
  def show
    this_month_spends = 0
    @budget.categories.each do |c|
      this_month_spends += c.this_month_balance
    end
    @this_month_spends = this_month_spends
  end

  def new
    @budget = Budget.new
    @categories = current_user.categories.where(category_type: 'Expense')
  end

  # GET /budgets/1/edit
  def edit
    @categories = current_user.categories.where(category_type: 'Expense')
  end

  # POST /budgets
  def create
    @budget = Budget.new(budget_params)
    @budget.user = current_user

    respond_to do |format|
      if @budget.save
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end

    # if @budget.save
    #   redirect_to @budget
    # else
    #   render :new
    # end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  def destroy
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_budget
    @budget = Budget.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def budget_params
    # category_ids = params[:budget][:category_ids]&.reject(&:blank?)
    # category_objs = Category.where(id: category_ids)
    params.require(:budget).permit(:amount, :name, category_ids: [])
  end
end
