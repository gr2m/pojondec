class Account < ActiveRecord::Base
  attr_accessible :currency, :details, :name, :number, :processor
  has_many :transactions, :dependent => :destroy

  def import(upload)
    processor.constantize.process upload
  end
end
