# frozen_string_literal: true

module Clients
  module Reddit
    class PostTitle
      TITLE_REGEXP = /^((\[\s*[\w-]*\s*\])*\s*)(.*)$/
      TAGS_REGEXP = /\[\s*([\w-]+)\s*\]/
      private_constant :TITLE_REGEXP, :TAGS_REGEXP

      attr_reader :title

      def initialize(title)
        @title = title
      end

      def title_without_tags
        matches.last
      end

      def tags
        parse_tags(matches.first)
      end

      private

      def matches
        @matches ||= TITLE_REGEXP.match(title).to_a.drop(1)
      end

      def parse_tags(prefixes)
        prefixes.scan(TAGS_REGEXP).to_a.flatten
      end
    end
  end
end
