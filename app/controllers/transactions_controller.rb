class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  
    @selected_month = params[:month].present? ? params[:month].to_i : Date.today.month
    @selected_year = params[:year].present? ? params[:year].to_i : Date.today.year
  
    start_date = Date.new(@selected_year, @selected_month, 1).beginning_of_month
    end_date = start_date.end_of_month
  
    @transactions = @transactions.where("DATE(created_at) BETWEEN ? AND ?", start_date, end_date)
    @total_amount = @transactions.sum(:amount)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new(full_name: current_user.full_name)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.full_name = current_user.full_name  # Asegurar que siempre use el nombre del usuario actual
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.created_at = Time.current  # Asegura que se guarde la fecha actual

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: "Gasto registrado exitosamente." }
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
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_transaction
      # Hay un error aquí: params.expect(:id) debería ser params[:id]
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:full_name, :amount, :image, :description)
    end
end
