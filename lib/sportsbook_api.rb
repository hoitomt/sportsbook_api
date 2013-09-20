$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')
require "sportsbook_api/version"
require "sportsbook_api/sportsbook_config"
require "sportsbook_api/parse_tickets"
require "sportsbook_api/sportsbook"
require "sportsbook_api/ticket"
require "sportsbook_api/ticket_line_item"

module SportsbookApi
  class << self
    THIS_MONTH = "THIS_MONTH"
    LAST_DAY = "LAST_DAY"
    LAST_3_DAYS = "LAST_3_DAYS"
    LAST_WEEK = "LAST_WEEK"
    LAST_31_DAYS = "LAST_31_DAYS"
    PREVIOUS_MONTH = "PREVIOUS_MONTH"
    PREVIOUS_MONTH_2 = "PREVIOUS_MONTH_2"
    PREVIOUS_MONTH_3 = "PREVIOUS_MONTH_3"
    PREVIOUS_MONTH_4 = "PREVIOUS_MONTH_4"
    PREVIOUS_MONTH_5 = "PREVIOUS_MONTH_5"
    PREVIOUS_MONTH_6 = "PREVIOUS_MONTH_6"

    attr_accessor :username, :password

    def configure
      yield self if block_given?
    end

    def config
      @config ||= SportsbookApi::SportsbookConfig.new(@username, @password)
    end

    def sportsbook
      SportsbookApi::Sportsbook.new(config)
    end

    def get_tickets
      sportsbook.get_tickets(LAST_31_DAYS)
    end

    def get_tickets_this_month
      sportsbook.get_tickets(THIS_MONTH)
    end

    def get_tickets_last_day
      sportsbook.get_tickets(LAST_DAY)
    end

    def get_tickets_last_3_days
      sportsbook.get_tickets(LAST_3_DAYS)
    end

    def get_tickets_last_week
      sportsbook.get_tickets(LAST_WEEK)
    end

    def get_tickets_last_31_days
      sportsbook.get_tickets(LAST_31_DAYS)
    end

    def get_tickets_previous_month
      sportsbook.get_tickets(PREVIOUS_MONTH)
    end

    def get_tickets_previous_month_2
      sportsbook.get_tickets(PREVIOUS_MONTH_2)
    end

    def get_tickets_previous_month_3
      sportsbook.get_tickets(PREVIOUS_MONTH_3)
    end

    def get_tickets_previous_month_4
      sportsbook.get_tickets(PREVIOUS_MONTH_4)
    end

    def get_tickets_previous_month_5
      sportsbook.get_tickets(PREVIOUS_MONTH_5)
    end

    def get_tickets_previous_month_6
      sportsbook.get_tickets(PREVIOUS_MONTH_6)
    end

  end
end

# credentials = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config/credentials.yml'))
# SportsbookApi.configure do |config|
#   config.username = credentials['username']
#   config.password = credentials['password']
# end
# puts SportsbookApi.get_tickets_last_week