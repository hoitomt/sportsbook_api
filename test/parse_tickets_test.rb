require_relative 'test_helper'

describe SportsbookApi::ParseTickets do
  include TestHelper

  let(:response){sportsbook_response}

  describe 'parse tickets' do
    let(:tickets){SportsbookApi::ParseTickets.new(response).extract}
    let(:first_ticket){tickets.first}

    it 'should parse the file' do
      tickets.length.must_equal 19
    end

    it 'should set the attributes' do
      first_ticket.sb_bet_id.must_equal 419369799
      first_ticket.amount_wagered.must_equal 5.0
      first_ticket.amount_to_win.must_equal 4.59
      first_ticket.outcome.must_equal 'Won'
    end
  end

  describe 'parse line items' do
    let(:game){sportsbook_game}
    let(:line_item){SportsbookApi::ParseTickets.new(response).create_line_item(game)}
    let(:line_item_date){Time.new(2013, 8, 29, 18, 05)}

    it "should parse the away_team" do
      line_item[:away_team].must_equal 'NorthCarolina'
      line_item[:home_team].must_equal 'SCarolina'
      line_item[:away_score].must_equal '10'
      line_item[:home_score].must_equal '27'
      line_item[:line_item_date].must_equal line_item_date
      line_item[:line_item_spread].must_equal 'SCarolina -13 (-105)'
    end
  end

end

