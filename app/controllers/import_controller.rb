class ImportController < ApplicationController
  def create
    @import = Import.new(params[:import])
    @import.process

    redirect_to uploads_path, notice: "#{@import.files.count} files successfully imported."
  end
end
