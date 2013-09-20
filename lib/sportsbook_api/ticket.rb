require 'virtus'
require 'json'

module SportsbookApi
  class Ticket
    include Virtus

    class TicketLineItem
      include Virtus

      attribute :away_team,         String
      attribute :away_score,        Integer
      attribute :home_team,         String
      attribute :home_score,        Integer
      attribute :line_item_date,    Time
      attribute :line_item_spread,  String
    end

    attribute :sb_bet_id,         Integer
    attribute :wager_date,        Time
    attribute :type,              String
    attribute :amount_wagered,    Float
    attribute :amount_to_win,     Float
    attribute :outcome,           String
    attribute :ticket_line_items, Array[TicketLineItem]

    def to_hash
      {
        sb_bet_id: sb_bet_id,
        wager_date: wager_date,
        type: type,
        amount_wagered: amount_wagered,
        amount_to_win: amount_to_win,
        outcome: outcome,
        ticket_line_items: line_items_hash
      }
    end

    private

    def line_items_hash
      ticket_line_items.map{|ticket_line_item| ticket_line_item.attributes}
    end
  end
end