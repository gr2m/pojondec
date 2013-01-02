require 'csv'

class Upload < ActiveRecord::Base
  belongs_to      :account
  has_many        :transactions, :dependent => :destroy

  attr_accessible :account_id, :file, :filename, :contents, :checksum
  attr_accessor   :file

  validates       :account_id, :presence => true
  validates       :file, :presence => true, :on => :create

  before_save     :read_file
  after_create    :process!
  after_update    :reprocess!

  def self.process(file)
    numbers_processors = Account.all.map { |account| [account.number, account.processor.constantize]}
    contents = file.read.force_encoding("ISO-8859-1").encode("UTF-8")

    numbers_processors.each do |number, processor|
      if processor.compatible? contents, number
        account = Account.find_by_number number
        upload = self.new({
          :account_id => account.id, 
          :filename => file.original_filename,
          :contents => contents,
          :checksum => Digest::MD5.hexdigest(contents)
        })
        return upload.save :validate => false
      end
    end  

    raise "could not find account for #{file.original_filename}\n\n#{contents}"
  end

  def read_file
    if file.present?
      self.filename = file.original_filename
      self.contents = file.read.force_encoding("ISO-8859-1").encode("UTF-8")
      self.checksum = Digest::MD5.hexdigest self.contents
    end 
  end
  def process!
    self.account.import self
    update_column :is_processed, true
  end

  def reprocess!
    self.transactions.destroy_all
    process!
  end

  def to_csv
    contents
  end
end
