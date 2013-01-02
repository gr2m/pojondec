class Import

  # http://stackoverflow.com/questions/10823736/undefined-method-model-name-for-projectclass
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :files

  def persisted?
    false
  end

  def initialize(properties = {})
    self.files = properties['files']
  end
  def process
    self.files.each do |file|
      Upload.process file
    end
  end
end