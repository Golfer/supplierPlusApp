module ApplicationHelper
  include Pagy::Frontend

  def due_date(invoice)
    invoice.due_date ? l(invoice.due_date) : ''
  end
end
