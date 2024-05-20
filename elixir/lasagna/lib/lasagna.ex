defmodule Lasagna do
  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(actual_time) do
    expected_minutes_in_oven() - actual_time
  end

  def preparation_time_in_minutes(n_layers) do
    n_layers * 2
  end

  def total_time_in_minutes(n_layers, current_time) do
    preparation_time_in_minutes(n_layers) + current_time
  end

  def alarm() do
    "Ding!"
  end
end
