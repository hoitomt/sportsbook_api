$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')
require "sportsbook_api/version"
require "sportsbook_api/sportsbook_config"
require "sportsbook_api/parse_tickets"
require "sportsbook_api/sportsbook"
require "sportsbook_api/ticket"
require "sportsbook_api/ticket_line_item"

module SportsbookApi
  class << self
    def play
      config = SportsbookApi::SportsbookConfig.new
      tickets = SportsbookApi::Sportsbook.new(config).get_tickets
      p tickets
    end
  end
end

# SportsbookApi.play