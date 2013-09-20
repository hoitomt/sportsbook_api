require 'mechanize'

module SportsbookApi
	class Sportsbook

		URL = 'http://www.sportsbook.ag/livesports/login.php'
		WAGERS_URL = 'https://www.sportsbook.ag/sbk/sportsbook4/www.sportsbook.ag/recenttx.ctr?siteID=7000'

		def initialize(config)
			@config = config
		end

		def get_tickets(date_range)
			data = get_sb_data(date_range)
			ParseTickets.new(data).extract
		end

		def get_sb_data(date_range)
			login
			polish get_wager_data(date_range)
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

		def get_wager_data(date_range="LAST_31_DAYS")
			mechanize_agent.get(WAGERS_URL) do |page|
				filter_form = page.form_with(:name => 'getBets') do |filter|
					raise "Sportsbook.ag Error - Likely unsuccessful login" unless filter
					filter.betState = "0"
					filter.dateRangeMode = date_range
				end.submit
				return filter_form.body
			end
		rescue => e
			puts e.message
			# puts e.backtrace
		end

		def polish(doc)
			doc.gsub!(/\\r|\\t|\\n|\\/, '')
			doc.gsub!(/\s{2,}/, ' ')
			Nokogiri::HTML(doc)
		end

	end
end