# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Pokedex::Application.load_tasks


task "local:cache:clear" do
  `rm -rf tmp/cache/*`
end

namespace :image do
  task :list do
    Dir["app/assets/images/*.png"].each do |image|
      next unless image =~ /\d{3}\.png/
      puts `identify #{image}`
    end
  end

  task :max_dimensions do
    max_width = 120
    max_height = 120

    Dir["app/assets/images/*.png"].each do |image|
      next unless image =~ /\d{3}\.png/

      image_results = `identify #{image}`

      # app/assets/images/717.png PNG 177x120 177x120+0+0 8-bit sRGB 9.59KB 0.000u 0:00.000
      dimensions = image_results.split(" ")[2]
      height, width = dimensions.split("x");
      max_height = height.to_i if height.to_i > max_height
      max_width = width.to_i if width.to_i > max_width
    end

    puts "Max WidthxHeight (#{max_width},#{max_height})"
  end

  task :uniform do
    Dir["app/assets/images/*.png"].each do |image|
      next unless image =~ /\d{3}\.png/
      puts "Converting #{image}"

      resize_command = "convert #{image} -resize 200x200 -gravity center -background transparent #{image}"
      `#{resize_command}`
      canvas_command = "convert #{image} -gravity center -background transparent -extent 200x200 #{image}"
      `#{canvas_command}`

    end

  end
end