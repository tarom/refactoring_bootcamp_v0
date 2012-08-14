#! /usr/bin/env ruby
#coding: utf-8

require './employee.rb'
require 'test/unit'

class TestEmployee < Test::Unit::TestCase
  def setup
    @employee = Employee.new
  end

  def test_get_members
    members = @employee.get_members
    assert_equal(members.size, 5)
    assert_equal(members.include?('alice'), true)
    assert_equal(members.include?('bob'), true)
    assert_equal(members.include?('charlie'), true)
    assert_equal(members.include?('dave'), true)
    assert_equal(members.include?('eve'), true)
  end

  def test_get_payment
    payments = @employee.get_payment
    assert_equal(payments.size, 5)
    assert_equal(payments['alice'], 100.0 * 1.1)         #110
    assert_equal(payments['bob'], 120.0 * 1.1 * 2)       #264
    assert_equal(payments['charlie'], 150.0 * 1.1 * 1.5) #247.5
    assert_equal(payments['dave'], 200.0 * 1.1 * 10)     #2200
    assert_equal(payments['eve'], 150)                   #150
  end

  def test_get_payment
    holidays = @employee.get_holidays
    assert_equal(holidays.size, 5)
    assert_equal(holidays['alice'], 10 + 5)       #15
    assert_equal(holidays['bob'], 10 + 10 - 5)    #15
    assert_equal(holidays['charlie'], 10 + 2 - 2) #10
    assert_equal(holidays['dave'], 10 + 5 - 10)   #5
    assert_equal(holidays['eve'], 10)             #10
  end
end

class TestEmployeeView < Test::Unit::TestCase
  def setup
    @employee_view = EmployeeView.new
  end

  def test_view_eomployee
    view = @employee_view.view_employee
    assert_equal(view, <<EOF)
<table>
<tr><th>名前</th><th>休暇日数</th><th>給与金額</th></tr>
<tr><td>alice</td><td style="color: green">15</td><td style="color: red">110.0</td></tr>
<tr><td>bob</td><td style="color: green">15</td><td>264.0</td></tr>
<tr><td>charlie</td><td>10</td><td>247.5</td></tr>
<tr><td>dave</td><td style="color: blue">5</td><td style="color: green">2200.0</td></tr>
<tr><td>eve</td><td>10</td><td>150.0</td></tr>
</table>
EOF
  end
end