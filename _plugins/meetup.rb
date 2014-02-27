require 'rmeetup'
require 'markaby'

module Jekyll
  class Meetup < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      
      secrets = YAML::load(File.read('_secrets.yml'))
      RMeetup::Client.api_key = secrets['meetup_api_key']
      @text = text
    end
    
    def render(context)

      events = RMeetup::Client.fetch(:events,{:group_urlname => "Jozi-Linux-User-Group-JLUG"})
      mab = Markaby::Builder.new
      if @text == "latest "
      then
        unless events.empty?
        then
          event = events.first
          mab.span :class => 'vevent' do
            mab.a :href => event.event_url do 
              
              mab.span :class => 'summary' do
                event.name
              end
              mab.span do
                " on " + event.time.strftime("%d %B @ %H:%M").to_s
              end
            end
            
            mab.span :class => 'dtstart', :style => 'display: none;' do
              event.time.iso8601.to_s
            end
          end        
        else 
          mab.a :href => 'http://www.google.com' do 
            "No meetup scheduled yet"
          end
        end
      end
      
      mab.to_s
    end
  end
end
  
Liquid::Template.register_tag('meetup', Jekyll::Meetup)
