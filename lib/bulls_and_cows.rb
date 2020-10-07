# frozen_string_literal: true

class BullsAndCows
  def initialize
    @letters = 5
  end

  def start
    win = false
    words = filter_words_by_length(@letters, filter_isogram_words(wordlist))
    answer = words.sample

    until win do 
      puts "#{word_as_stars(answer)}\n\n"
      print 'Guess word: '
      guess = gets.chomp
      puts ""

      if validate_guess(guess, answer) == false
        puts "Error: Incorrect number of characters.\n\n"
      else
        bulls_count = bulls(guess, answer)
        cows_count = cows(guess, answer)
        bulls_and_cows_string = "#{bulls_and_cows(guess, answer)}\n\n"
        puts "#{bulls_count} bulls, #{cows_count} cows"
        puts bulls_and_cows_string

        if win?(guess, answer)
          win = true
          puts "WINNER!\n\n"
          print 'Continue? (y/n): '
          continue = gets.chomp
          puts ""

          if continue == 'y'
           start
          elsif continue == 'n'
            exit
          end
        end
      end
    end
  end

  def wordlist
    File.open('data/wordlist.txt').readlines.map(&:chomp)
  end

  def filter_isogram_words(words)
    words.select do |word|
      word.chars.uniq.length == word.chars.length
    end
  end

  def filter_words_by_length(length, words)
    words.select do |word|
      word.length == length
    end
  end

  def validate_guess(guess, answer)
    guess.length == answer.length
  end

  def bulls(guess, answer)
    bulls = 0
    answer.chars.each_with_index do |char, index|
      bulls += 1 if guess.chars[index] == char
    end
    bulls
  end

  def cows(guess, answer)
    cows = 0
    answer.chars.each_with_index do |char, index|
      cows += 1 if guess.chars[index] != char
    end
    cows
  end

  def bulls_and_cows(guess, answer)
    bulls_and_cows = []
    answer.chars.each_with_index do |char, index|
      if guess.chars[index] == char
        bulls_and_cows << 'bull'
      else
        bulls_and_cows << 'cow'
      end  
    end
    bulls_and_cows.join(', ')
  end

  def word_as_stars(word)
    word_as_stars = []
    word.chars.each_with_index do |char, index|
      if index == 0
        word_as_stars << char 
      else
        word_as_stars << '*'
      end
    end
    word_as_stars.join(' ')
  end

  def win?(guess, answer)
    guess == answer
  end
end
