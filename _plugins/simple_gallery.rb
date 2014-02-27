require 'csv'
require 'markaby'
require 'exifr'

class String
  def downcase_and_hyphenate
    self.downcase.gsub(/(\s|\/)/, "-")
  end
end

module Jekyll
  class SimpleGallery < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.split(" ").first
    end
    
    def render(context)
      mab = Markaby::Builder.new
      particular_gallery = @text
      Dir.foreach("_originals/#{particular_gallery}/") do |x| 
        unless x.match('^\.')
        then 
          if x.match('\.jpg$')
          then
            mab.a :class => "gallery",:title => EXIFR::JPEG.new("_originals/#{particular_gallery}/#{x}").comment.to_s,:href => "/images/#{particular_gallery}/full_#{x}" do 
              mab.img :src => "/images/#{particular_gallery}/100px_#{x}",:alt => "image!",:class => "bordered"
            end
          end
        end
      end


      mab.to_s
      
    end
  end
end

Liquid::Template.register_tag('simple_gallery', Jekyll::SimpleGallery)
