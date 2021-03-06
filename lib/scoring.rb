module Scrabble

  class Scoring

    LETTERVALUES = {
      :A => 1,
      :E => 1,
      :I => 1,
      :O => 1,
      :U => 1,
      :L => 1,
      :N => 1,
      :R => 1,
      :S => 1,
      :T => 1,
      :D => 2,
      :G => 2,
      :B => 3,
      :C => 3,
      :M => 3,
      :P => 3,
      :F => 4,
      :H => 4,
      :V => 4,
      :W => 4,
      :Y => 4,
      :K => 5,
      :J => 8,
      :X => 8,
      :Q => 10,
      :Z => 10
    }

    attr_accessor :word

    def initialize
      @word = word
    end

    def self.score(word_to_score)
      # take argument & convert to upcase
      @word = word_to_score.upcase
      # split argument in an array of letters
      letter_array = @word.split('')
      values_of_letters = []
      # check each letter of input against constant Hash and return the value of that key
      letter_array.each do |letter|
        letter = letter.to_sym
        tile_value = LETTERVALUES.fetch(letter, "x")
        values_of_letters << tile_value
      end
      # store the returned values in an array.
      if values_of_letters.include?("x")
        sum = nil
      elsif values_of_letters.length > 7 || values_of_letters.length < 1
        sum = nil
      else
        sum = values_of_letters.sum
      end
      if values_of_letters.length == 7
        sum += 50
      end
      return sum
    end

    def self.highest_score_from(array_of_words)
      if array_of_words.length == 0
        return nil
      else
        # .map iterates through array)of_words and runs the self.score method on each word, retuning each score in the scores_array
        scores_array = array_of_words.map { |word| score(word) }
        # .max finds the highest number in scores_array
        high_score = scores_array.max
        # .each_with_index.select is iterating through the scores_array and returning an array of arrays, each one holding the score number that is equal to high_score, and it's index. Then the .map iterates through the array of arrays and stores JUST the index (at position[1] in each array) inside the winning_indices array.
        winning_indices = scores_array.each_with_index.select { |score, index| score == high_score }.map { |array| array[1]}
        winning_words = []
        winning_indices.each do |index|
          winning_words << array_of_words.values_at(index)
        end
        # .flatten! takes our array of arrays and condenses it into one array
        winning_words.flatten!
        # if there's only one word in the array, return that word
        # if winning_words.length == 1
        #   return winning_words[0]
        # if there are multiple words in the array, return the word with 7 letters
        if winning_words.any? { |word| word.length == 7 }
          return winning_words.find { |word| word.length == 7 }
        else
          return winning_words.min_by(&:length)
        end
      end
    end

  end

end



#
