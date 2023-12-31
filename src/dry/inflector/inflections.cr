# frozen_string_literal: true

require "set"
require "./rules"
require "./acronyms"
require "./inflections/defaults"

module Dry
  class Inflector
    # Inflections
    #
    # @since 0.1.0
    class Inflections
      # Instantiate a set of inflection rules.
      # It adds the default rules and the optional customizations, passed as a block.
      #
      # @param blk [Proc] the optional, custom rules
      #
      # @since 0.1.0
      # @api private
      def self.build(&blk : self -> Nil) : Inflections
        new do |inflect|
          puts "proc arg is #{inflect.class}"
          Defaults.call(inflect)
          blk.call(inflect)
        end
      end

      def self.build : Inflections
        new do |inflect|
          Defaults.call(inflect)
        end
      end

      # Pluralization rules
      #
      # @return [Dry::Inflector::Rules]
      #
      # @since 0.1.0
      # @api private
      getter plurals

      # Singularization rules
      #
      # @return [Dry::Inflector::Rules]
      #
      # @since 0.1.0
      # @api private
      getter singulars

      # Uncountable rules
      #
      # @return [Set]
      #
      # @since 0.1.0
      # @api private
      getter uncountables = Set(String).new

      # Human rules
      #
      # @return [Dry::Inflector::Rules]
      #
      # @since 0.1.0
      # @api private
      getter humans

      # Acronyms
      #
      # @return [Dry::Inflector::Acronyms]
      #
      # @since 0.1.2
      # @api private
      getter acronyms

      # Instantiate the rules
      #
      # @return [Dry::Inflector::Inflections]
      # @yieldparam [self]
      #
      # @since 0.1.0
      # @api private
      def initialize(& : self -> Nil)
        @plurals = Rules.new
        @singulars = Rules.new
        @humans = Rules.new
        @acronyms = Acronyms.new

        yield(self)
      end

      def initialize
        @plurals = Rules.new
        @singulars = Rules.new
        @humans = Rules.new
        @acronyms = Acronyms.new
      end

      # Add a custom pluralization rule
      #
      # Specifies a new pluralization rule and its replacement.
      # The rule can either be a string or a regular expression.
      #
      # The replacement should always be a string that may include
      # references to the matched data from the rule.
      #
      # @param rule [String, Regex] the rule
      # @param replacement [String] the replacement
      #
      # @since 0.1.0
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.plural "virus", "viruses"
      #   end
      def plural(rule, replacement)
        rule(rule, replacement, plurals)
      end

      # Add a custom singularization rule
      #
      # Specifies a new singularization rule and its replacement.
      # The rule can either be a string or a regular expression.
      #
      # The replacement should always be a string that may include
      # references to the matched data from the rule.
      #
      # @param rule [String, Regex] the rule
      # @param replacement [String] the replacement
      #
      # @since 0.1.0
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.singular "thieves", "thief"
      #   end
      def singular(rule, replacement)
        rule(rule, replacement, singulars)
      end

      # Add a custom pluralization rule
      #
      # Specifies a new irregular that applies to both pluralization
      # and singularization at the same time.
      #
      # This can only be used for strings, not regular expressions.
      # You simply pass the irregular in singular and plural form.
      #
      # @param singular [String] the singular
      # @param plural [String] the plural
      #
      # @since 0.1.0
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.singular "octopus", "octopi"
      #   end
      def irregular(singular, plural)
        uncountables.delete(singular)
        uncountables.delete(plural)

        add_irregular(singular, plural, plurals)
        add_irregular(plural, singular, singulars)
      end

      # Add a custom rule for uncountable words
      #
      # Uncountable will not be inflected
      #
      # @param [Enumerable<String>] words
      #
      # @since 0.1.0
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.uncountable "money"
      #     inflections.uncountable "money", "information"
      #     inflections.uncountable %w(money information rice)
      #   end
      def uncountable(word)
        uncountables.add(word)
      end

      def uncountable(words : Enumerable(String))
        words.flatten.each { |w| uncountables.add(w) }
      end

      # Add one or more acronyms
      #
      # Acronyms affect how basic operations are performed, such
      # as camelize/underscore.
      #
      # @param words [Array<String>] a list of acronyms
      #
      # @since 0.1.2
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.acronym "HTML"
      #   end
      #
      #   inflector.camelize("html")        # => "HTML"
      #   inflector.underscore("HTMLIsFun") # => "html_is_fun"
      def acronym(words : Enumerable(String))
        words.each { |word| @acronyms.add(word.downcase, word) }
      end

      def acronym(word)
        @acronyms.add(word.downcase, word)
      end

      # Add a custom humanize rule
      #
      # Specifies a humanized form of a string by a regular expression rule or
      # by a string mapping.
      #
      # When using a regular expression based replacement, the normal humanize
      # formatting is called after the replacement.
      #
      # When a string is used, the human form should be specified as desired
      # (example: `"The name"`, not `"the_name"`)
      #
      # @param rule [String, Regex] the rule
      # @param replacement [String] the replacement
      #
      # @since 0.1.0
      #
      # @example
      #   require "dry/inflector"
      #
      #   inflector = Dry::Inflector.new do |inflections|
      #     inflections.human(/_cnt$/i, '\1_count')
      #     inflections.human("legacy_col_person_name", "Name")
      #   end
      def human(rule, replacement)
        humans.insert(0, {rule, replacement})
      end

      # Add irregular inflection
      #
      # @param rule [String] the rule
      # @param replacement [String] the replacement
      #
      # @return [undefined]
      #
      # @since 0.1.0
      # @api private
      private def add_irregular(rule, replacement, target)
        head, *tail = rule.chars.to_a
        rule(/(#{head})#{tail.join}\z/i, "\\1#{replacement[1..]}", target)
      end

      # Add a new rule
      #
      # @param rule [String, Regex] the rule
      # @param replacement [String, Regex] the replacement
      # @param target [Dry::Inflector::Rules] the target
      #
      # @since 0.1.0
      # @api private
      private def rule(rule, replacement, target)
        uncountables.delete(rule)
        uncountables.delete(replacement)

        target.insert(0, {rule, replacement})
      end
    end
  end
end
