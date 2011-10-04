
path = File.expand_path "../../", __FILE__
photos = Dir.glob("#{path}/public/photos/*/**")
#puts photos

photos.each_with_index do |photo, idx|
  `sips --resampleWidth 2000 --resampleHeight 1500 #{photo}` if idx < 21
end