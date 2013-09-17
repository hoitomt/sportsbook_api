require 'mechanize'

module SportsbookApi
	class Sportsbook

		URL = 'http://www.sportsbook.ag/livesports/login.php'
		WAGERS_URL = 'https://www.sportsbook.ag/sbk/sportsbook4/www.sportsbook.ag/recenttx.ctr?siteID=7000'

		def initialize(config)
			@config = config
		end

		def get_tickets
			px = ParseTickets.new(get_sb_data)
			px.extract
		end

		def get_sb_data
			login
			polish get_wager_data
		end

		def mechanize_agent
			@agent ||= Mechanize.new { |agent|
				agent.user_agent_alias = 'Mac Safari'
				agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
				agent.ssl_version = "SSLv3"
			}
		end

		def login
			mechanize_agent.get(URL) do |page|
				login_result = page.form_with(:name => 'sportsbook') do |login|
					login.username = @config.username
					login.password = @config.password
				end.click_button
			end
		end

		def get_wager_data
			mechanize_agent.get(WAGERS_URL) do |page|
				filter_form = page.form_with(:name => 'getBets') do |filter|
					filter.betState = "0"
					filter.dateRangeMode = "LAST_31_DAYS"
				end.submit
				return filter_form.body
			end
		end

		def polish(doc)
			doc.gsub!(/\\r|\\t|\\n|\\/, '')
			doc.gsub!(/\s{2,}/, ' ')
			Nokogiri::HTML(doc)
		end

	end
end