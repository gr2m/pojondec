require 'csv'

class DeutscheBankCc

  attr_accessor :upload

  def self.compatible?(contents, number)
    lines = contents.split(/[\r?\n]/)
    return if number.blank?

    pattern = Regexp.new("\\b" + number.split('').join("\\s?") + "\\b")
    
    return unless lines[0]['Kreditkartentransaktionen']
    return unless lines[1] =~ pattern

    return true
  end

  def self.process(upload)
    self.new(upload)
  end

  def initialize(upload)
    self.upload = upload

    lines = upload.contents.split(/[\r?\n]/)
    lines.shift(5) # remove meta data
    lines.pop(1)   # remove total ammount

    csv = CSV.parse(lines.join("\n"), :col_sep => ";")
    csv.each do |row|
      create_transaction_from row
    end
  end

  def create_transaction_from(row)

    transaction = upload.transactions.new

    if row[0].length == 10
      date_format = '%d.%m.%Y'
    else
      date_format = '%d.%m.%y'
    end

    transaction.booking_date = Date.strptime row[0], date_format

    transaction.details      = row[2]
    transaction.amount       = (row[6].gsub(/ /, '').gsub(/[,.]/, '.').to_f * 100).round
    transaction.account_id   = self.upload.account_id
    transaction.is_new       = true

    transaction.save
  end
end