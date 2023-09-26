# frozen_string_literal: true

module Dry
  class Inflector
    # A set of acronyms
    #
    # @since 0.1.2
    # @api private
    class Acronyms
      getter :regex

      # @since 0.1.2
      # @api private
      def initialize
        @rules = Hash(String, String).new
        define_regex_patterns
      end

      # @since 0.1.2
      # @api private
      def apply_to(word, capitalize : Bool = true)
        word = word.not_nil!
        @rules[word.downcase]? || (capitalize ? word.capitalize : word)
      end

      # @since 0.1.2
      # @api private
      def add(rule, replacement)
        @rules[rule] = replacement
        define_regex_patterns
      end

      # @since 0.1.2
      # @api private
      private def define_regex_patterns
        regex = @rules.empty? ? /(?=a)b/ : /#{@rules.values.join("|")}/
        @regex = /(?:(?<=([A-Za-z\d]))|\b)(#{regex})(?=\b|[^a-z])/
      end
    end
  end
end
