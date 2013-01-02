require 'csv'

class Ubs

  attr_accessor :upload

  def self.compatible?(contents, number)
    lines = contents.gsub(/\s*$/, '').split(/[\n]/)
    return if number.blank?

    pattern = Regexp.new("\\b" + number.split('').join("\\s?") + "\\b")

    return unless lines[0]['Bewertungsdatum']
    return unless lines[1] =~ pattern

    return true
  end

  def self.process(upload)
    self.new(upload)
  end

  def initialize(upload)
    self.upload = upload

    lines = upload.contents.split("\n")
    lines.shift(1) # remove meta data
    lines.pop(3)   # remove total ammount

    csv = CSV.parse(lines.join("\n").gsub("\r", ""), :col_sep => ";", :row_sep => "\n")
    csv.each do |row|
      create_transaction_from row
    end
  end

  def create_transaction_from(row)
    transaction = upload.transactions.new

    transaction.booking_date = Date.strptime row[0], '%d.%m.%y'
    transaction.details      = row[12..14].join("\n")
    transaction.remote_id    = row[15]
    if row[18]
      transaction.amount     = row[18].gsub(/[,.']/, '').to_i * -1
    else
      transaction.amount     = row[19].gsub(/[,.']/, '').to_i
    end
    
    transaction.account_id   = self.upload.account_id

    transaction.save
  end
end
