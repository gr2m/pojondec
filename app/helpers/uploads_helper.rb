module UploadsHelper
  def css_classes_for_upload(upload)
    classes = []
    if upload.transactions.sum(:amount) < 0
      classes.push 'debit'
    else
      classes.push 'credit'
    end

    unless upload.is_processed?
      classes.push 'new'
    end

    classes.join ' '
  end
end
