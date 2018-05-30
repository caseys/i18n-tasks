require 'pry'

# frozen_string_literal: true

module I18n::Tasks::Scanners
  module RubyKeyLiterals
    LITERAL_RE = /:?".+?"|:?'.+?'|:\w+/

    # Match literals:
    # * String: '', "#{}"
    # * Symbol: :sym, :'', :"#{}"
    def literal_re
      LITERAL_RE
    end

    # remove the leading colon and unwrap quotes from the key match
    # @param literal [String] e.g: "key", 'key', or :key.
    # @return [String] key
    def strip_literal(literal)
      literal = literal[1..-1] if literal[0] == ':'
      literal = literal[1..-2] if literal[0] == "'" || literal[0] == '"'
      literal
    end

    def valid_key_chars
      config[:valid_key_chars] || /(?:[[:word:]]|[-.?!:;À-ž])/
    end

    def valid_key_re
      /^#{valid_key_chars}+$/
    end

    def valid_key?(key)
      key =~ valid_key_re && !key.end_with?('.')
    end
  end
end
