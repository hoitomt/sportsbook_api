require 'virtus'

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