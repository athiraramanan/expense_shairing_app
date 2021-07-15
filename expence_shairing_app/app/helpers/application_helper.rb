module ApplicationHelper
	
	def with_precision(number)
    number_to_currency(number)
  end

  def format_date(date)
    if date.present?
      date.to_date.strftime('%d/%m/%Y')
    else
      '--'
    end
  end
end
