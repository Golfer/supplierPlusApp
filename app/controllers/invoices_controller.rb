class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[show edit update destroy]

  # GET /invoices or /invoices.json
  def index
    @pagy, @invoices = pagy(Invoice.where(user: current_user))
  end

  # GET /invoices/1 or /invoices/1.json
  def show; end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_path, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:user, :amount, :due_date, :sell_price)
  end
end
