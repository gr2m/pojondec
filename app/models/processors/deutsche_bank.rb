require 'csv'

class DeutscheBank

  attr_accessor :upload

  def self.compatible?(contents, number)
    lines = contents.split(/[\r?\n]/)
    return if number.blank?

    pattern = Regexp.new("\\b" + number.split('').join("\\s?") + "\\b")

    return unless lines[0]['Ums']
    return unless lines[0] =~ pattern
    
    return true
  end

  def self.process(upload)
    self.new(upload)
  end

  def initialize(upload)
    self.upload = upload

    lines = upload.contents.split("\n")
    lines.shift(5) # remove meta data
    lines.pop(1)   # remove total ammount

    csv = CSV.parse(lines.join("\n"), :col_sep => ";")
    csv.each do |row|
      create_transaction_from row
    end
  end

  def create_transaction_from(row)
    transaction = upload.transactions.new

    transaction.booking_date = Date.parse row[0]
    transaction.details      = row[2]
    transaction.amount       = (row[3] or row[4]).gsub(/[,.]/, '').to_i
    transaction.account_id   = self.upload.account_id

    transaction.save
  end
end
