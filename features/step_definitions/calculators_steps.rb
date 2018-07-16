def previous_tax_years
  today = Date.today
  threshold = Date.new(today.year, 4, 5)
  years = [today.year - 1, today.year]
  years = years.map { |y| y - 1 } if today < threshold
  years
end

Then(/^I should be able to see the previous tax year$/) do
  within(".tax-year") do
    expect(page).to have_content(previous_tax_years.join(" to "))
  end
end
