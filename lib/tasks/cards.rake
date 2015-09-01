require 'nokogiri'
require 'open-uri'

namespace :cards do
  desc "load latest cards"
  task load: :environment do

    Card.destroy_all
    ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'cards'")
    cards = open('https://www.cardsagainsthumanity.com/wcards.txt', 'r:utf-8', &:read)
    cards = cards.gsub("cards=","").split("<>")
    cards.each do |card|
      Card.create(name: card)
    end

  end
end
