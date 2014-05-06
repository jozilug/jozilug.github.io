# Encoding: utf-8
require 'rmeetup'
require 'markaby'

module Jekyll
  # This is where missing top-level class documentation comment goes
  class Meetup < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      secrets = YAML.load(File.read('_secrets.yml'))
      meetup = RMeetup::Client
      meetup.api_key = secrets['meetup_api_key']
      begin
        @events = meetup.fetch(:events,
                               group_urlname: 'Jozi-Linux-User-Group-JLUG')
        rescue
        @events = []
      end
      @text = text.split(' ').first
    end

    def render(context)
      mab = Markaby::Builder.new
      if @text == 'latest'
        if @events.empty?
          mab.a href: 'http://www.meetup.com/Jozi-Linux-User-Group-JLUG' do
            'No meetup scheduled yet. Why don\'t you suggest one?'
          end
        else
          event = @events.first
          mab.span class: 'vevent' do
            mab.a href: event.event_url do
              mab.span class: 'summary' do
                event.name
              end
              mab.span do
                ' on ' + event.time.strftime('%d %B @ %H:%M').to_s
              end
            end
            mab.span class: 'dtstart', style: 'display: none;' do
              event.time.iso8601.to_s
            end
          end
        end
      end
      mab.to_s
    end
  end
end

Liquid::Template.register_tag('meetup', Jekyll::Meetup)
