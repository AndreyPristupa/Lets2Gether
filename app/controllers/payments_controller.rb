class PaymentsController < ApplicationController
  include PaymentsHelper
  before_action :set_payment, only: [:show, :edit]
  skip_before_action :verify_authenticity_token, only: :success
  def callback
    options = params[:payment].from_url_params
    payment = Payment.find(options[:order]);
    payment.amount = options[:amount]
    payment.save
  end

  def success

  end

  def privat24
    redirect_to root_path unless params[:project_id]
    payment = Payment.new(user_id: current_user.id ? current_user.id : 0,
                           project_id:params[:project_id],
                           payment_system_id: Constants::PRIVATE24,
                           status_id:Constants::STATUS_WAIT
    )
    @payment = payment
    payment.save
    @params = params
    @options = payments_list[:private24]
  end

  def paymentslist
    respond_to do |f|
      f.html {render partial: 'payments/partials/paymentlist', locals: {}}
    end
  end

  private
  private_key = '71zg6qt1C039d4q6NPF28XW4Tq0ru16H'
    def private24(payment)

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:user_id, :project_id, :payment_system_id, :amount, :currency, :status_id)
    end

  def self.from_url_params(url_params)
    result = {}.with_indifferent_access
    url_params.split('&').each do |element|
      element = element.split('=')
      result[element[0]] = element[1]
    end
    result
  end
end
