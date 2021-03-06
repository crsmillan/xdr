defmodule XDR.Type.BoolTest do
  use ExUnit.Case
  alias XDR.Type.Bool
  alias XDR.Type.Int

  test "length" do
    assert Bool.length === 4
  end

  test "new" do
    assert Bool.new(true) == {:ok, true}
    assert Bool.new(false) == {:ok, false}

    assert Bool.new(0) == {:error, :invalid}
    assert Bool.new(nil) == {:error, :invalid}
    assert Bool.new("true") == {:error, :invalid}
    assert Bool.new([]) == {:error, :invalid}
    assert Bool.new({}) == {:error, :invalid}
  end

  test "valid?" do
    assert Bool.valid?(true) == true
    assert Bool.valid?(false) == true

    assert Bool.valid?(nil) == false
    assert Bool.valid?(0) == false
    assert Bool.valid?("0") == false
    assert Bool.valid?([]) == false
    assert Bool.valid?({}) == false
  end

  test "encode" do
    assert Bool.encode(false) == Int.encode(0)
    assert Bool.encode(true) == Int.encode(1)

    assert Bool.encode(nil) == {:error, :invalid}
  end

  test "decode" do
    assert Bool.decode(<<0, 0, 0, 0>>) == {:ok, {false, <<>>}}
    assert Bool.decode(<<0, 0, 0, 1>>) == {:ok, {true, <<>>}}
    assert Bool.decode(<<0, 0, 0, 1, 0, 0, 0, 0>>) == {:ok, {true, <<0, 0, 0, 0>>}}

    assert Int.decode(2) == {:error, :invalid}
  end
end
