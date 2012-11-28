path = File.expand_path "../", __FILE__
APP_PATH = path
require 'sinatra'

require "#{path}/config/env"

get '/' do
  # @type = "editorial"
  # haml :gallery
  haml :home
end

get '/css/main.css' do
  sass :main
end


get "/editorial" do
  haml :editorial
end


get "/personal" do
  haml :personal
end

sub_galleries = [
  "editorial/see_me_not"              ,
  "editorial/teen_dream"              ,
  "editorial/displaced"              ,
  "editorial/lost_highway"              ,
  "editorial/ophelia"              ,
  "editorial/grand_hotel_lynch"              ,
  "editorial/pauline"                        ,
  "editorial/much_madness_is_divinest_sense" ,
  "editorial/faith_and_ambiguity"            ,
  "personal/one"            ,
  "personal/two"            ,
  "personal/three"            ,
  ]

galleries = %w(fashion portrait music) + sub_galleries
galleries.flatten.each do |gallery|
  get "/#{gallery}" do
    @type = gallery
    haml :gallery
  end
end

get "/press" do
  haml :press
end

get "/contact" do
  haml :contact
end

get '/links' do
  haml :links
end
