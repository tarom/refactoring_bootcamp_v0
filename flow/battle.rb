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
end

class Battle
  attr_reader :turn

  def initialize(first, second)
    @first = first
    @second = second
    @turn = 1
  end

  def atack(atacker, defencer)
    if (atacker.atack > defencer.defence)
      damage = atacker.atack - defencer.defence
      is_elemental_bonus = false

      if atacker.element == :dark || defencer.element == :dark
        return false
      elsif atacker.element != defencer.element
        if (atacker.element == :water || defencer.element == :water) && 
           (atacker.element == :fire || defencer.element == :fire)
          is_elemental_bonus = true
        end
        if (atacker.element == :wind || defencer.element == :wind) && 
           (atacker.element == :earth || defencer.element == :earth)
          is_elemental_bonus = true
        end
      end
      damage *= 2 if is_elemental_bonus
      if defencer.life < damage
        defencer.life = 0
      else
        defencer.life -= damage
      end
    end
    true
  end

  def start
    loop do
      return nil if !atack(@first, @second)
      return @first if @second.life <= 0
      return nil if !atack(@second, @first)
      return @second if @first.life <= 0
      @turn += 1
    end
  end
end
