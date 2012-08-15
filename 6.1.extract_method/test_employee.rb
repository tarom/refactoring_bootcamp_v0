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
    payments = @employee.get_payment(2012, 8)
    assert_equal(payments.size, 5)
    assert_equal(payments['alice'], 100.0 * 1.2)         #120
    assert_equal(payments['bob'], 120.0 * 1.1 * 2)       #264
    assert_equal(payments['charlie'], 150.0 * 1.3 * 1.5) #292.5
    assert_equal(payments['dave'], 200.0 * 1.2 * 10)     #2400
    assert_equal(payments['eve'], 150)                   #150
  end

  def test_get_holiday
    holidays = @employee.get_holiday(2012, 8)
    assert_equal(holidays.size, 5)
    assert_equal(holidays['alice'], 10 + 5)       #15
    assert_equal(holidays['bob'], 10 + 10 - 5)    #15
    assert_equal(holidays['charlie'], 10 + 3 - 2) #11
    assert_equal(holidays['dave'], 10 + 6 - 10)   #6
    assert_equal(holidays['eve'], 10)             #10
  end

  def test_get_work_month
    work_month = @employee.get_work_month(2012, 8)
    assert_equal(work_month.size, 5)
    assert_equal(work_month['alice'], 58)
    assert_equal(work_month['bob'], 119)
    assert_equal(work_month['charlie'], 28)
    assert_equal(work_month['dave'], 67)
    assert_equal(work_month['eve'], 4)
  end
end

class TestEmployeeView < Test::Unit::TestCase
  def setup
    @employee_view = EmployeeView.new
  end

  def test_view_eomployee
    view = @employee_view.view_employee(2012, 8)
    assert_equal(view, <<EOF)
<table>
<tr><th>名前</th><th>休暇日数</th><th>給与金額</th><th>勤続年数</th></tr>
<tr><td>alice</td><td style="color: green">15</td><td style="color: red">120.0</td><td>4</td></tr>
<tr><td>bob</td><td style="color: green">15</td><td>264.0</td><td>9</td></tr>
<tr><td>charlie</td><td>11</td><td>292.5</td><td>2</td></tr>
<tr><td>dave</td><td style="color: blue">6</td><td style="color: green">2400.0</td><td>5</td></tr>
<tr><td>eve</td><td>10</td><td>150.0</td><td>0</td></tr>
</table>
EOF
  end
end