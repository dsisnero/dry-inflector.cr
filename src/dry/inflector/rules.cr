# frozen_string_literal: true

module Dry
  class Inflector
    # A set of inflection rules
    #
    # @since 0.1.0
    # @api private
    class Rules
      # @since 0.1.0
      # @api private
      alias RuleType = {String, String} | {Regex | String}

      def initialize
        @rules = [] of {String, String} | {Regex, String}
      end

      # @since 0.1.0
      # @api private
      def apply_to(word)
        result = word.dup
        new_result = nil
        each do |(rule, replacement)|
          new_result = result.gsub(rule, replacement)
          break if new_result != result || (rule.is_a?(Regex) && result.match rule)
        end
        new_result || result
      end

      # @since 0.1.0
      # @api private
      def insert(index, rule_tuple)
        @rules.insert(index, rule_tuple)
      end

      # @since 0.1.0
      # @api private
      def each(&)
        @rules.each { |r| yield r }
      end
    end
  end
end
