module BudgetsHelper
  def css_classes_for_budget(budget)
    classes = []
    if budget.allocations.sum(:amount) < 0
      classes.push 'debit'
    else
      classes.push 'credit'
    end

    classes.join ' '
  end
end
