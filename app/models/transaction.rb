class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :upload
  has_many :allocations, :dependent => :destroy
  attr_accessible :amount, :booking_date, :details, :is_new, :account_id, :remote_id, :allocations_attributes, :note
  validates_uniqueness_of :details, :scope => [:booking_date, :amount]
  validates :account_id, :presence => true

  accepts_nested_attributes_for :allocations
  after_update :destroy_allocations_without_amount
  
  private

  def destroy_allocations_without_amount
    allocations.where("amount IS NULL").destroy_all
  end
end