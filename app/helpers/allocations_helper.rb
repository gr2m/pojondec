module AllocationsHelper
  def css_classes_for_allocation(allocation)
    classes = []
    if allocation.amount < 0
      classes.push 'debit'
    else
      classes.push 'credit'
    end

    classes.join ' '
  end
end
