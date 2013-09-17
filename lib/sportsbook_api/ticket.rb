require 'virtus'

class Ticket
  include Virtus

  attribute :sb_bet_id,       Integer
  attribute :wager_date,      DateTime
  attribute :type,            String
  attribute :amount_wagered,  Float
  attribute :amount_to_win,   Float
  attribute :outcome,         String

end