require 'nokogiri'
module SportsbookApi
	class ParseTickets

		attr_accessor :document, :new_ticket_array, :new_ticket_line_item_array,
									:ticket, :sb_bet_id, :ticket_rows,
									:wager_date, :wager_type, :amount_wagered,
									:amount_to_win, :outcome, :away_team, :away_score,
									:home_team, :home_score, :line_item_date, :line_item_spread

		def initialize(doc)
			@document = doc
			@new_ticket_array = []
		end

		def extract
			result_tables = @document.css('div#wagerDetails > table > tr > td > div > table')
			result_tables.each do |table|
				@new_ticket_line_item_array = []
				@ticket_rows = table.css('> tr')
				@new_ticket_array << build_ticket
			end
			@new_ticket_array
		end

		def build_ticket
			set_bet_id
			set_wager_details
			@ticket = Ticket.new(
				:sb_bet_id => @sb_bet_id,
				:wager_date => @wager_date,
				:type => @wager_type,
				:amount_wagered => @amount_wagered,
				:amount_to_win => @amount_to_win,
				:outcome => @outcome,
				:ticket_line_items => set_line_items
			)
		end

		def set_bet_id
			bet_id_row = @ticket_rows[0]
			bet_id_match = bet_id_row.to_s.match(%r{BET ID=\d*})
			if bet_id_match
				bet_id = bet_id_match.to_s.split('=')
				@sb_bet_id = bet_id[1].to_i
			else
				@sb_bet_id = 0
			end
		end

		def set_wager_details
			wager_details_rows = @ticket_rows[1].css('> td > table > tr')
			set_wager_date(wager_details_rows)
			set_wager_type(wager_details_rows)
			set_wager_amounts(wager_details_rows)
			set_outcome(wager_details_rows)
		end

		def set_wager_type(rows)
			wager_type = rows[0].css('> td > span')[0]
			@wager_type = wager_type.children[0].content
		end

		def set_wager_date(rows)
			wd = rows[0].css('> td > span')[1]
			wd = wd.children[0].content
			wd.gsub!('ET', '')
			@wager_date = Time.strptime(wd, "%m/%d/%y %H:%M")
		end

		def set_wager_amounts(rows)
			wager_amounts = rows[1].css('> td > span')[0]
			set_amount_wagered(wager_amounts)
			set_amount_to_win(wager_amounts)
		end

		def set_amount_wagered(wager_amounts)
			match_txt = wager_amounts.to_s.match(%r{bet \d*\W\d*})
			@amount_wagered = match_txt.to_s.split(' ')[1] if match_txt
		end

		def set_amount_to_win(wager_amounts)
			match_txt = wager_amounts.to_s.match(%r{to win \d*\W\d*})
			@amount_to_win = match_txt.to_s.split(' ')[2] if match_txt
		end

		def set_outcome(rows)
			outcome_dirty = rows[1].css('> td > span')[1]
			match_txt = outcome_dirty.children[0].to_s
			# match_txt = outcome_dirty.to_s.match(%r{Result:\w*})
			@outcome = match_txt.to_s.split(' ').last if match_txt
		end

		def set_line_items
			size = @ticket_rows.size
			game_details_row = @ticket_rows[2..size]
			games = game_details_row.css('table')
			line_item_list = []
			games.each do |game|
				set_teams(game)
				set_date_wager(game)
				line_item_list << create_line_item
			end
			return line_item_list
		end

		def create_line_item
			line_item = TicketLineItem.new(
				:away_team => @away_team,
				:away_score => @away_score,
				:home_team => @home_team,
				:home_score => @home_score,
				:line_item_date => @line_item_date,
				:line_item_spread => @line_item_spread
			)
		end

		def set_teams(game)
			teams = game.css('span')[0].try(:children)
			if teams.nil?
				return nil
			else
				away_array = teams[0].to_s.split(' ')
				home_array = teams[2].to_s.split(' ')
				@away_team = away_array[0]
				@home_team = home_array[0]
				if teams.size == 3
					@away_score = away_array[1]
					@home_score = home_array[1]
				end
			end
		end

		def set_date_wager(game)
			time_spread = game.css('span')[1].children
			wd = time_spread[0].to_s
			wd.gsub!('ET', '')
			wd.gsub!(/\(|\)/, ' ').try(:lstrip!).try(:rstrip!)
			begin
				@line_item_date = Time.strptime(wd, "%m/%d/%y %H:%M")
				@line_item_spread = time_spread[2]
			rescue
				# invalid date
			end
		end

	end
end