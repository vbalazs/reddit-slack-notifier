# frozen_string_literal: true

require "test_helper"

module Clients
  module Reddit
    class PostTitleTest < Minitest::Test
      def test_title_without_tags
        cases = {
          "Fun post [maybe]" => "Fun post [maybe]",
          "Funny [not] post" => "Funny [not] post",
          "[ ruby ][elixir] Very interesting" => "Very interesting",
          "[big-data][r_lang] Very interesting" => "Very interesting",
          "[dev-ops] Never forget" => "Never forget",
          "[] Haxor" => "Haxor",
          "[   ] H4xor" => "H4xor"
        }

        cases.each do |input, expected|
          object = PostTitle.new(input)
          assert_equal expected, object.title_without_tags
        end
      end

      def test_tags
        cases = {
          "Fun post [maybe]" => [],
          "Funny [not] post" => [],
          "[] Haxor" => [],
          "[   ] H4xor" => [],
          "[java] Never forget" => %w[java],
          "[ ruby ][elixir] Very interesting" => %w[ruby elixir],
          "[big-data][r_lang] Very interesting" => %w[big-data r_lang]
        }

        cases.each do |input, expected|
          object = PostTitle.new(input)
          assert_equal expected, object.tags
        end
      end
    end
  end
end
