# coding: utf-8

class Character
  attr_accessor :life
  attr_reader :atack
  attr_reader :defence
  attr_reader :element

  def initialize(life, atack, defence, element)
    @life = life
    @atack = atack
    @defence = defence
    @element = element
  end

  def atack(defencer)
    if @element == :dark || defencer.element == :dark
        return false
    elsif @atack > defencer.defence
      damage = @atack - defencer.defence
      damage *= 2 if is_elemental_bonus(defencer)
      if defencer.life < damage
        defencer.life = 0
      else
        defencer.life -= damage
      end
    end
    true
  end

private
  def is_elemental_bonus(defencer)
    result = false
    if @element != defencer.element
      if (@element == :water || defencer.element == :water) && 
         (@element == :fire || defencer.element == :fire)
        result = true
      end
      if (@element == :wind || defencer.element == :wind) && 
         (@element == :earth || defencer.element == :earth)
        result = true
      end
    end
    result
  end
end

class Battle
  attr_reader :turn

  def initialize(first, second)
    @first = first
    @second = second
    @turn = 1
  end

  def start
    loop do
      return nil if !@first.atack(@second)
      return @first if @second.life <= 0
      return nil if !@second.atack(@first)
      return @second if @first.life <= 0
      @turn += 1
    end
  end
end
