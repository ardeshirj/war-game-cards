# Hold information about the game cards
class Card
  attr_reader :deck

  def initialize(shuffle = true)
    # (clubs, hearts, spades, diamonds)
    # [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]

    suits = %w(c h s d)
    card_set = Card.gen_card_set
    @deck = card_set.product(suits).map { |c, _s| c.to_s }
    @deck.shuffle! if shuffle
  end

  def size
    @deck.size
  end

  def pass_card(count)
    @deck.pop(count)
  end

  def self.rank(played_cards)
    cards_rank = {}
    card_set = Card.gen_card_set

    played_cards.each do |player_id, cards|
      rank = 0
      rank = card_set.find_index(cards.last) + 2 unless cards.last.nil?
      cards_rank[player_id] = rank
    end
    cards_rank
  end

  def self.gen_card_set
    ('2'..'10').to_a + %w(J Q K A)
  end

  def self.show_last_played_cards(match, war_cards)
    match.players.each do |player|
      print "Player[#{player.id}] (#{player.cards.size} cards): "
      print 'X ' if war_cards
      puts match.played_cards[player.id].last
    end
    # p player.cards
  end
end
