# frozen_string_literal: true

class Check
  def initialize(total_combinaton, size_checker, suit, size)
    @total_combinaton = total_combinaton
    @s_ch = size_checker
    @suit = suit
    @size = size
  end

  def stritflash_hearts
    flash_check_heart && (@win_flash_hearts.flatten[8] - @win_flash_hearts.flatten[0] == 4)
  end

  def stritflash_diamonds
    flash_check_diamonds && (@win_flash_diamonds.flatten[8] - @win_flash_diamonds.flatten[0] == 4)
  end

  def stritflash_clubs
    flash_check_clubs && (@win_flash_clubs.flatten[8] - @win_flash_clubs.flatten[0] == 4)
  end

  def stritflash_spades
    flash_check_spades && (@win_flash_spades.flatten[8] - @win_flash_spades.flatten[0] == 4)
  end

  def four_1
    @total_combinaton[0] == @total_combinaton[3]
  end

  def four_2
    @total_combinaton[1] == @total_combinaton[4]
  end

  def four_3
    @total_combinaton[2] == @total_combinaton[5]
  end

  def four_4
    @total_combinaton[3] == @total_combinaton[6]
  end

  def fullhouse
    if three_1 && para_4
      @fullhouse = @total_combinaton[2..6]
    elsif three_1 && para_5
      @fullhouse = @total_combinaton[1, 2] + @total_combinaton[4..6]
    elsif three_1 && para_6
      @fullhouse = @total_combinaton[0, 1] + @total_combinaton[4..6]
    elsif three_2 && para_5
      @fullhouse = @total_combinaton[1..5]
    elsif three_2 && para_6
      @fullhouse = @total_combinaton[0..1] + @total_combinaton[3..5]
    elsif three_3 && para_1
      @fullhouse = @total_combinaton[2..6]
    elsif three_3 && para_6
      @fullhouse = @total_combinaton[0..4]
    elsif three_4 && para_1
      @fullhouse = @total_combinaton[1..3] + @total_combinaton[5, 6]
    elsif three_4 && para_2
      @fullhouse = @total_combinaton[1..5]
    elsif three_5 && para_1
      @fullhouse = @total_combinaton[0..2] + @total_combinaton[5, 6]
    elsif three_5 && para_2
      @fullhouse = @total_combinaton[0..2] + @total_combinaton[4, 5]
    elsif three_5 && para_3
      @fullhouse = @total_combinaton[0..4]
    end
  end

  def flash_check_diamonds
    diamonds_flash_creator = @size + %w[C H S]
    flash_diamonds = diamonds_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_diamonds = @total_combinaton - flash_diamonds
    @win_flash_diamonds.size >= 5
  end

  def flash_check_spades
    spades_flash_creator = @size + %w[C D H]
    flash_spades = spades_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_spades = @total_combinaton - flash_spades
    @win_flash_spades.size >= 5
  end

  def flash_check_heart
    hearts_flash_creator = @size + %w[C D S]
    flash_hearts = hearts_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_hearts = @total_combinaton - flash_hearts
    @win_flash_hearts.size >= 5
  end

  def flash_check_clubs
    clubs_flash_creator = @size + %w[D H S]
    flash_clubs = clubs_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_clubs = @total_combinaton - flash_clubs
    @win_flash_clubs.size >= 5
  end

  def strit_check_firts
    (@s_ch[12] - @s_ch[4] == 4) && (@s_ch[12] - @s_ch[6] == 3) && (@s_ch[12] - @s_ch[8] == 2) && (@s_ch[12] - @s_ch[10] == 1)
  end

  def strit_check_middle
    (@s_ch[10] - @s_ch[2] == 4) && (@s_ch[10] - @s_ch[4] == 3) && (@s_ch[10] - @s_ch[6] == 2) && (@s_ch[10] - @s_ch[8] == 1)
  end

  def strit_check_last
    (@s_ch[8] - @s_ch[0] == 4) && (@s_ch[8] - @s_ch[2] == 3) && (@s_ch[8] - @s_ch[4] == 2) && (@s_ch[8] - @s_ch[6] == 1)
  end

  def strit_check_exeption
    (@s_ch[6] - @s_ch[0] == 3) && (@s_ch[6] - @s_ch[2] == 2) && (@s_ch[6] - @s_ch[4] == 1) && (@s_ch[12] - @s_ch[6] == 9)
  end

  def twopairs
    if para_1 && para_3 || para_1 && para_4 || para_2 && para_4
      @twopairswin = @total_combinaton[2..6]
    elsif para_1 && para_5 || para_2 && para_5
      @twopairswin = @total_combinaton[1, 2] + @total_combinaton[4..6]
    elsif para_1 && para_6 || para_2 && para_6
      @twopairswin = @total_combinaton[0..1] + @total_combinaton[4..6]
    elsif para_3 && para_5
      @twopairswin = @total_combinaton[1..4] + @total_combinaton[6]
    elsif para_3 && para_6
      @twopairswin = @total_combinaton[0..1] + @total_combinaton[3..4] + @total_combinaton[6]
    elsif para_4 && para_6
      @twopairswin = @total_combinaton[0..3] + @total_combinaton[6]
    end
  end

  def para_1
    @s_ch[12] == @s_ch[10]
  end

  def para_2
    @s_ch[10] == @s_ch[8]
  end

  def para_3
    @s_ch[8] == @s_ch[6]
  end

  def para_4
    @s_ch[6] == @s_ch[4]
  end

  def para_5
    @s_ch[4] == @s_ch[2]
  end

  def para_6
    @s_ch[2] == @s_ch[0]
  end

  def three_1
    @s_ch[12] == @s_ch[8]
  end

  def three_2
    @s_ch[10] == @s_ch[6]
  end

  def three_3
    @s_ch[8] == @s_ch[4]
  end

  def three_4
    @s_ch[6] == @s_ch[2]
  end

  def three_5
    @s_ch[4] == @s_ch[0]
  end

  def win
    if stritflash_hearts
      puts 'Straight Flush'
      @win_flash_hearts
    elsif stritflash_diamonds
      puts 'Straight Flush'
      @win_flash_diamonds
    elsif stritflash_spades
      puts 'Straight Flush'
      @win_flash_spades
    elsif stritflash_clubs
      puts 'Straight Flush'
      @win_flash_clubs
    elsif four_4 || four_3
      puts 'Four of a kind'
      @total_combinaton[2..6]
    elsif four_2
      puts 'Four of a kind'
      @total_combinaton[1..5]
    elsif four_1
      puts 'Four of a kind'
      @total_combinaton[0..4]
    elsif fullhouse
      puts 'Fullhouse'
      @fullhouse
    elsif flash_check_clubs
      puts 'Flush'
      @win_flash_clubs
    elsif flash_check_heart
      puts 'Flush'
      @win_flash_hearts
    elsif flash_check_spades
      puts 'Flush'
      @win_flash_spades
    elsif flash_check_diamonds
      puts 'Flush'
      @win_flash_diamonds
    elsif strit_check_firts
      puts 'Straight'
      @total_combinaton[2..6]
    elsif strit_check_middle
      puts 'Straight'
      @total_combinaton[1..5]
    elsif strit_check_last
      puts 'Straight'
      @total_combinaton[0..4]
    elsif strit_check_exeption
      puts 'Straight'
      @total_combinaton[0..3] + @total_combinaton[6]
    elsif twopairs
      puts 'Two Pairs'
      @twopairswin
    elsif three_1 || three_2 || three_3
      puts 'Three of a kind'
      @total_combinaton[2..6]
    elsif three_4
      puts 'Three of a kind'
      @total_combinaton[1..3] + @total_combinaton[5, 6]
    elsif three_5
      puts 'Three of a kind'
      @total_combinaton[0..2] + @total_combinaton[5, 6]
    elsif para_1 || para_2 || para_3 || para_4
      puts 'Pair'
      @total_combinaton[2..6]
    elsif para_5
      puts 'Pair'
      @total_combinaton[1..2] + @total_combinaton[4..6]
    elsif para_6
      puts 'Pair'
      @total_combinaton[0..1] + @total_combinaton[4..6]
    else
      puts 'High card'
      @total_combinaton[2..6]
    end
  end
end

size = (2..14).to_a
suit = %w[S C D H]
card_combinator = size + suit
deck = card_combinator.combination(2).to_a - size.combination(2).to_a - suit.combination(2).to_a
shuffled_deck = deck.shuffle
hand = shuffled_deck[1, 2]
table = shuffled_deck[3..7]
total_combinaton = hand + table
total_combinaton = total_combinaton.sort_by { |elem| elem[0] }
size_checker = total_combinaton.flatten
check = Check.new(total_combinaton, size_checker, suit, size)

print hand
puts '- your cards'
print table
puts '- cards on table'
puts 'Win combination:'
print check.win
puts
