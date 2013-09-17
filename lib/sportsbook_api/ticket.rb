require 'virtus'

module SportsbookApi
  class Ticket
    include Virtus

    class TicketLineItem
      include Virtus

      attribute :type,              String
      attribute :away_team,         String
      attribute :away_score,        Integer
      attribute :home_team,         String
      attribute :home_score,        Integer
      attribute :line_item_date,    Date
      attribute :line_item_spread,  String
    end

    attribute :sb_bet_id,         Integer
    attribute :wager_date,        DateTime
    attribute :type,              String
    attribute :amount_wagered,    Float
    attribute :amount_to_win,     Float
    attribute :outcome,           String
    attribute :ticket_line_items, Array[TicketLineItem]

  end
end