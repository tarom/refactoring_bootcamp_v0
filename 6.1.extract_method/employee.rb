#coding: utf-8

#ここはリファクタリング対象外
class MockEmployee
   attr_reader :name
   attr_reader :payment_base
   attr_reader :complete_years
   attr_reader :position

  def initialize(name, payment_base, complete_years, position)
    @name = name
    @payment_base = payment_base
    @complete_years = complete_years
    @position = position
  end
end

class MockEmployeeDB
  def initialize
    @member = []
    @member << MockEmployee.new('alice', 100.0, 5, :none) 
    @member << MockEmployee.new('bob', 120.0, 10, :section_manager)
    @member << MockEmployee.new('charlie', 150.0, 2, :group_reader)
    @member << MockEmployee.new('dave', 200.0, 5, :general_manager)
    @member << MockEmployee.new('eve', 150.0, 0, :none)
  end

  def each(&block)
    @member.each(&block)
  end
end
#ここまでリファクタリング対象外

class Employee
  def initialize
    @employee_db = MockEmployeeDB.new
  end

  def get_members
    result = []
    @employee_db.each do |member|
      result << member.name
    end
    result
  end

  def get_payment
    result = {}
    @employee_db.each do |member|
      payment = member.payment_base
      # 勤続年数が1年以上ならば給料増額
      if member.complete_years > 1
        payment *= 1.1
      end

      # 役職毎の給料増額
      if member.position == :section_manager
        payment *= 2
      elsif member.position == :group_reader
        payment *= 1.5
      elsif member.position == :general_manager
        payment *= 10
      end
      
      result[member.name] = payment
    end
    result
  end

  def get_holidays
    result = {}
    @employee_db.each do |member|
      holiday = 10
      # 勤続年数が1年以上ならば休暇日数増加
      if member.complete_years > 1
        holiday += member.complete_years
      end

      # 役職によっては忙しいので休暇が実質無くなっていく
      if member.position == :section_manager
        holiday -= 5
      elsif member.position == :group_reader
        holiday -= 2
      elsif member.position == :general_manager
        holiday -= 10
      end

      result[member.name] = holiday
    end
    result
  end
end

class EmployeeView
  def initialize
    @employee = Employee.new
  end

  def view_employee
    result = ""
    result += "<table>\n"

    result += "<tr>"
    result += "<th>名前</th>"
    result += "<th>休暇日数</th>"
    result += "<th>給与金額</th>"
    result += "</tr>"
    result += "\n"

    payment = @employee.get_payment
    holidays = @employee.get_holidays

    # 休暇日数や、給与金額の最小・最大値の取得
    payment_max = nil
    payment_min = nil
    holidays_max = nil
    holidays_min = nil
    @employee.get_members.each do |member|
      payment_max = payment[member] if payment_max == nil || payment[member] > payment_max
      payment_min = payment[member] if payment_min == nil || payment[member] < payment_min
      holidays_max = holidays[member] if holidays_max == nil || holidays[member] > holidays_max
      holidays_min = holidays[member] if holidays_min == nil || holidays[member] < holidays_min
    end

    @employee.get_members.each do |member|
      result += "<tr>"
      result += "<td>#{member}</td>"
      if holidays[member] == holidays_min
        result += "<td style=\"color: blue\">#{holidays[member]}</td>"
      elsif holidays[member] == holidays_max
        result += "<td style=\"color: green\">#{holidays[member]}</td>"
      else
        result += "<td>#{holidays[member]}</td>"
      end

      if payment[member] == payment_min
        result += "<td style=\"color: red\">#{payment[member]}</td>"
      elsif payment[member] == payment_max
        result += "<td style=\"color: green\">#{payment[member]}</td>"
      else
        result += "<td>#{payment[member]}</td>"
      end

      result += "</tr>"
      result += "\n"
    end

    result += "</table>\n"

    result
  end
end
