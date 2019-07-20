defmodule EmailTldValidatorTest do
  use ExUnit.Case
  doctest EmailTldValidator

  test "greets the world" do
    assert EmailTldValidator.hello() == :world
  end
end
