class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]

  # GET /budgets or /budgets.json
  def index
    @budgets = Budget.all
  end

  # GET /budgets/1 or /budgets/1.json
  def show
    @budget = Budget.find(params[:id])
    @category = Category.find(1)
    # @target_budget = @category.budgets.sum(:amount)
    # @current_spending = @category.expenses.sum(:amount)
  end

  def new
    @budget = Budget.new
    @categories = current_user.categories.where(category_type: 'expense')
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
    @categories = current_user.categories.where(category_type: 'expense')
  end

  # POST /budgets or /budgets.json
  def create
    category_ids = params[:budget].delete(:category_ids) || []
    params[:budget][:categories] = Category.where(id: category_ids)

    @budget = Budget.new(budget_params)

    if @budget.save
      redirect_to @budget
    else
      render :new
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
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

  # DELETE /budgets/1 or /budgets/1.json
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
    params.require(:budget).permit(:amount, :name, :target_budget, categories: [])
  end
end

# POST /budgets or /budgets.json
# def create
#   # @budget = Budget.new(budget_params)
#   # @user_id = current_user
#   # @budget.user_id = @user_id
#   # @budget.save

#   # respond_to do |format|
#   #   if @budget.save
#   #     format.html { redirect_to budget_url(@budget), notice: "Budget was successfully created." }
#   #     format.json { render :show, status: :created, location: @budget }
#   #   else
#   #     format.html { render :new, status: :unprocessable_entity }
#   #     format.json { render json: @budget.errors, status: :unprocessable_entity }
#   #   end


#   #   @budget = Budget.new(budget_params)
#   #   @budget.categories = Category.where(id: params[:budget][:category_ids])

#   #   if @budget.save
#   #     redirect_to @budget
#   #   else
#   #     render :new
#   #   end
#   # end

# # GET /budgets/new
# end
