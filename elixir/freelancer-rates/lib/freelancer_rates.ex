defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * ((100 - discount) / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    before_discount = 22.0 * daily_rate(hourly_rate)
    after_discount = apply_discount(before_discount, discount)
    ceil(after_discount)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    days = budget / apply_discount(daily_rate(hourly_rate), discount)
    Float.floor(days, 1)
  end
end
