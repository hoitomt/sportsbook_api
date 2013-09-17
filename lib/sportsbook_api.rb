$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')
require "sportsbook_api/version"
require "sportsbook_api/parse_tickets"
require "sportsbook_api/sportsbook"

module SportsbookApi
end

SportsbookApi::Sportsbook.get_tickets