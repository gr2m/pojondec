class Allocation < ActiveRecord::Base
  belongs_to :budget
  belongs_to :transaction
  attr_accessible :amount, :budget_id, :transaction_id
  validates_uniqueness_of :transaction_id, :scope => :budget_id

  validates :transaction_id, :presence => true
  validates :budget_id, :presence => true
end
