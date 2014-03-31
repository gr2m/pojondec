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

  def transactions_from_to(upload)
    return "" unless upload.transactions.present?
    from = upload.transactions.minimum(:booking_date).strftime "%d.%m.%Y"
    to = upload.transactions.maximum(:booking_date).strftime "%d.%m.%Y"

    "#{from} - #{to}"
  end
end
