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

sub_galleries = [
  "editorial/teen_dream"              ,
  "editorial/displaced"              ,
  "editorial/lost_highway"              ,
  "editorial/ophelia"              ,
  "editorial/grand_hotel_lynch"              ,
  "editorial/pauline"                        ,
  "editorial/much_madness_is_divinest_sense" ,
  "editorial/faith_and_ambiguity"            ,
  ]

galleries = %w(fashion portrait personal) + sub_galleries
galleries.flatten.each do |gallery|
  get "/#{gallery}" do
    @type = gallery
    haml :gallery
  end
end

get "/contact" do
  haml :contact
end

get '/links' do
  haml :links
end
