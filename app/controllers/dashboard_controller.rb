class DashboardController < ApplicationController
  def index
    @new_transactions = Transaction.where(:is_new => true)
    @allocations = Allocation.scoped
    @budgets = Budget.all
    @accounts = Account.all
    @import = Import.new
  end
end
