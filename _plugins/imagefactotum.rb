require 'find'
require 'rmagick'
require 'optipng'


module Jekyll
  class ImageFactotum < Generator 
    def generate(site)

      Find.find("_originals") do |original_file_path|
        unless (FileTest.directory?(original_file_path) or original_file_path =~ /DS_Store/ )
        then
          original_file_path_array = original_file_path.split(File::SEPARATOR) 
          original_file_path_array[0] = "images" 
          
          original_basename = File.basename(original_file_path) 
          
          original = Magick::ImageList.new(original_file_path) 
          unless (original_file_path_array.length == 2) 
          then
            thumb = original.resize_to_fill(100,100)
            full = original.resize_to_fit(1024,500)
          else
            thumb = original.resize_to_fill(100,100)
            full = original.resize_to_fit(570,570)
          end

          new_basename_full = "full_" + original_basename
          new_basename_thumb = "100px_" + original_basename
          new_thumb_path = (original_file_path_array[0...-1] + [new_basename_thumb]).join(File::SEPARATOR)
          new_full_path = (original_file_path_array[0...-1] + [new_basename_full]).join(File::SEPARATOR)

          unless Dir.exist?(File.dirname(new_thumb_path))
            Dir.mkdir(File.dirname(new_thumb_path))
          end
          
          thumb.strip!
          full.strip!

          full.write(new_full_path)
          thumb.write(new_thumb_path)

          original.destroy!
          thumb.destroy!
          full.destroy!
          
          if (new_thumb_path =~ /\.jpg/) 
          then 
            puts "JPG: #{new_thumb_path}"
          elsif (new_thumb_path =~ /\.png/)
            puts "PNG: #{new_thumb_path}"
            Optipng.optimize([new_thumb_path], { :level => 7 })
            Optipng.optimize([new_full_path], { :level => 7 })
          end
          
        end
      end
    end
  end
end

