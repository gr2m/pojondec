module TransactionsHelper

  def new_transactions_path
    transactions_path :search => { :is_new_is_true => 1 }
  end
end
