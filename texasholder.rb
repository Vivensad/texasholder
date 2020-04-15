class Check
  def initialize(total_combinaton, size_checker, suit, size)
    @total_combinaton = total_combinaton
    @size_checker = size_checker
    @suit = suit
    @size = size
  end 

  def flash_check_diamonds
    diamonds_flash_creator = @size + ['C','H','S']
    flash_diamonds = diamonds_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_diamonds = @total_combinaton - flash_diamonds
    @win_flash_diamonds.size >=5
  end

  def flash_check_spades
    spades_flash_creator = @size + ['C','D','H']
    flash_spades = spades_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_spades = @total_combinaton - flash_spades
    @win_flash_spades.size >= 5
  end

  def flash_check_heart
    hearts_flash_creator = @size + ['C','D','S']
    flash_hearts = hearts_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_hearts =  @total_combinaton - flash_hearts
    @win_flash_hearts.size >= 5
  end

  def flash_check_clubs
    clubs_flash_creator = @size + ['D','H','S']
    flash_clubs = clubs_flash_creator.combination(2).to_a - @size.combination(2).to_a - @suit.combination(2).to_a
    @win_flash_clubs = @total_combinaton - flash_clubs
    @win_flash_clubs.size >= 5
  end

  def strit_check_firts
    @size_checker[12] - @size_checker[4] == 4 and @size_checker[12] - @size_checker[6] == 3 and @size_checker[12] - @size_checker[8] == 2 and @size_checker[12] - @size_checker[10] == 1
  end

  def strit_check_middle
    @size_checker[10] - @size_checker[2] == 4 and @size_checker[10] - @size_checker[4] == 3 and @size_checker[10] - @size_checker[6] == 2 and @size_checker[10] - @size_checker[8] == 1
  end

  def strit_check_last
    @size_checker[8] - @size_checker[0] == 4 and @size_checker[8] - @size_checker[2] == 3 and @size_checker[8] - @size_checker[4] == 2 and @size_checker[8] - @size_checker[6] == 1
  end

  def para_prelast
    @size_checker[4] == @size_checker[2]
  end

  def para_last
    @size_checker[2] == @size_checker[0]
  end

  def three_first
    @size_checker[6] == @size_checker[2]   
  end

  def three_last
    @size_checker[4] == @size_checker[0]   
  end

  def win
    if flash_check_clubs
      @win_flash_clubs
    elsif flash_check_heart
      @win_flash_hearts
    elsif flash_check_spades 
      @win_flash_spades
    elsif flash_check_diamonds 
      @win_flash_diamonds
    elsif strit_check_firts
      @total_combinaton[2..6]
    elsif strit_check_middle
      @total_combinaton[1..5]
    elsif strit_check_last
      @total_combinaton[0..4]
    elsif three_first
      @total_combinaton[1..3] + @total_combinaton[5,6]
    elsif three_last
      @total_combinaton[0..2] + @total_combinaton[5,6]
    elsif para_prelast
      @total_combinaton[1,2] + @total_combinaton[4..6]
    elsif para_last
      @total_combinaton[0,1] + @total_combinaton[4..6]
    else
      @total_combinaton[2..6]
    end
  end
end

size = (2..14).to_a
suit = ["S","C","D","H"]
card_combinator = size + suit
deck = card_combinator.combination(2).to_a - size.combination(2).to_a - suit.combination(2).to_a
shuffled_deck = deck.shuffle
hand = shuffled_deck[1,2]
table =  shuffled_deck[3..7]
total_combinaton = hand + table
total_combinaton = total_combinaton.sort_by {|elem| elem[0]}
size_checker = total_combinaton.flatten
check = Check.new(total_combinaton, size_checker, suit, size)

print hand
puts "- your cards"
print table
puts "- cards on table"
puts "Win combination:"
print check.win
