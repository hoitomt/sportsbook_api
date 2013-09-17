require 'mechanize'

module SportsbookApi
	class Sportsbook

		URL = 'http://www.sportsbook.ag/livesports/login.php'
		# WAGERS_URL = "https://sportsbook.gamingsystem.ag/sportsbook4/www.sportsbook.ag/wagers.cgi"
		WAGERS_URL = 'https://www.sportsbook.ag/sbk/sportsbook4/www.sportsbook.ag/recenttx.ctr?siteID=7000'

		def self.get_tickets
			doc = get_sb_data
			px = ParseTickets.new(polish(doc))
			# p px
			return px.extract
		end

		def self.polish(doc)
			doc.gsub!(/\\r|\\t|\\n|\\/, '')
			doc.gsub!(/\s{2,}/, ' ')
			Nokogiri::HTML(doc)
		end

		def self.get_sb_data
			a = Mechanize.new { |agent|
				agent.user_agent_alias = 'Mac Safari'
				agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
				agent.ssl_version = "SSLv3"
			}

			a.get(URL) do |page|
				login_result = page.form_with(:name => 'sportsbook') do |login|
					login.username = 'hoitomt'
					login.password = 'Anna33##'
				end.click_button
			end

			page = a.get(WAGERS_URL)
			puts page.inspect

			# a.get(WAGERS_URL) do |page|
			# 	filter_form = page.form_with(:name => 'getBets') do |filter|
			# 		filter.betState = "0"
			# 		filter.dateRangeMode = "LAST_31_DAYS"
			# 	end.submit
			# 	return filter_form.body
			# end
		end
	end
end