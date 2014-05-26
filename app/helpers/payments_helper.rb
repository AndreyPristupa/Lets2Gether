module PaymentsHelper
  def payments_list
    {private24:{merchant: '100995', server_url: callback_payments_url, return_url: success_payments_url, image:'privat-24.jpg', path: privat24_payments_path}}
  end
end
