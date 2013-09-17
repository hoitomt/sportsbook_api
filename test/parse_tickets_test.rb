require_relative 'test_helper'

describe SportsbookApi::ParseTickets do
  include TestHelper

  describe 'test' do
    it 'should run' do
      true.must_equal true
    end
  end

  describe 'parse tickets' do
    let(:response){sportsbook_response}
    let(:tickets){SportsbookApi::ParseTickets.new(response).extract}
    let(:first_ticket){tickets.first}
    let(:first_line_item){first_ticket.ticket_line_items.first}

    it 'should parse the file' do
      tickets.length.must_equal 19
    end

    it 'should set the attributes' do
      first_ticket.sb_bet_id.must_equal 419369799
      first_ticket.amount_wagered.must_equal 5.0
      first_ticket.amount_to_win.must_equal 4.59
      first_ticket.outcome.must_equal 'Won'
    end

    it 'should set the line item' do
      # p "First line item #{first_line_item.attributes}"
    end
  end

end

