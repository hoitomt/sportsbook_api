$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'minitest/autorun'
require 'sportsbook_api'

module TestHelper

  def sportsbook_response
    doc = File.read(File.expand_path(File.dirname(__FILE__) + '/fixtures/sportsbook_response.html'))
    polish doc
  end

  def sportsbook_game
    doc = File.read(File.expand_path(File.dirname(__FILE__) + '/fixtures/sportsbook_game.html'))
    polish doc
  end

  def polish(doc)
    doc.gsub!(/\\r|\\t|\\n|\\/, '')
    doc.gsub!(/\s{2,}/, ' ')
    Nokogiri::HTML(doc)
  end

end