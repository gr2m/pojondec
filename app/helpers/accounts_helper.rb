module AccountsHelper

  def account_transactions_path(account)
    transactions_path(:search => { :upload_id_equals => account.id })
  end
end
