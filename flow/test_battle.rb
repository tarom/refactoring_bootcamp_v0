#! /usr/bin/env ruby
# coding: utf-8

require 'test/unit'
require './battle.rb'

class TestBattle < Test::Unit::TestCase
  def test_start
    c1 = Character.new(1000, 1500, 500, :water)
    c2 = Character.new(1000, 1500, 500, :water)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, c1)
    assert_equal(c1.life, 1000)
    assert_equal(c2.life, 0)
    assert_equal(battle.turn, 1)

    c1 = Character.new(2000, 1500, 500, :wind)
    c2 = Character.new(2000, 1500, 500, :water)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, c1)
    assert_equal(c1.life, 1000)
    assert_equal(c2.life, 0)
    assert_equal(battle.turn, 2)

    c1 = Character.new(2000, 1500, 500, :fire)
    c2 = Character.new(2000, 1500, 500, :water)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, c1)
    assert_equal(c1.life, 2000)
    assert_equal(c2.life, 0)
    assert_equal(battle.turn, 1)

    c1 = Character.new(2000, 1000, 500, :earth)
    c2 = Character.new(2000, 1000, 500, :fire)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, c1)
    assert_equal(c1.life, 500)
    assert_equal(c2.life, 0)
    assert_equal(battle.turn, 4)

    c1 = Character.new(1500, 1000, 500, :earth)
    c2 = Character.new(2000, 1000, 500, :earth)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, c2)
    assert_equal(c1.life, 0)
    assert_equal(c2.life, 500)
    assert_equal(battle.turn, 3)

    c1 = Character.new(1500, 1000, 500, :earth)
    c2 = Character.new(2000, 1000, 500, :dark)
    battle = Battle.new(c1, c2)
    winner = battle.start
    assert_equal(winner, nil)

    
  end


end