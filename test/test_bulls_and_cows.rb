# frozen_string_literal: true

require 'minitest/autorun'
require_relative './test_helper'
require_relative '../lib/bulls_and_cows'

class TestBullsAndCows < Minitest::Test
  def setup
    @game = BullsAndCows.new
  end

  def test_can_load_wordlist
    refute_empty @game.wordlist
  end

  def test_words_are_chomped
    assert @game.wordlist.sample.chars.last != "\n"
  end

  def test_can_filter_isogram_words
    assert @game.filter_isogram_words(@game.wordlist).length != @game.wordlist.length
  end

  def test_can_filter_words_by_length
    length = 5
    assert @game.filter_words_by_length(length, @game.wordlist).sample.length == length
  end

  def test_can_validate_guess
    guess = '1234'
    answer = '12345'
    refute @game.validate_guess(guess, answer)
    guess = '12345'
    assert @game.validate_guess(guess, answer)
  end

  def test_can_get_bulls
    guess = '1234'
    answer = '1432'
    assert @game.bulls(guess, answer) == 2
  end

  def test_can_get_cows
    guess = '1234'
    answer = '1432'
    assert @game.cows(guess, answer) == 2
  end

  def test_bulls_and_cows
    guess = '1234'
    answer = '1432'
    assert @game.bulls_and_cows(guess, answer) == 'bull, cow, bull, cow'
  end

  def test_word_as_stars
    word = '1234'
    assert @game.word_as_stars(word) == '1 * * *'
  end

  def test_win
    guess = '1234'
    answer = '1234'
    assert @game.win?(guess, answer)
  end
end
