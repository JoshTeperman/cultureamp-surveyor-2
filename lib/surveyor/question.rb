module Surveyor
  class Question
    attr_reader :title, :value

    def initialize(hash)
      value = hash[:value]
      value_is_valid?(value)
      @title = hash[:title]
      @value = value
    end

    def title_is_valid?(title)
      title.class == String
    end

    def value_is_valid?(value)
      raise ArgumentError, 'Invalid Question: Question value cannot be empty' if value.nil?
      raise ArgumentError, 'Invalid Question: Question value must be a String' unless value.class == String
      raise ArgumentError, 'Invalid Question: Question value cannot be empty' if value.empty?
      raise ArgumentError, 'Invalid Question: Question value cannot be empty' if value =~ /\A\s*\z/
      raise ArgumentError, 'Invalid Question: Question value must be more than three characters long' unless value.length > 3

      true
    end
  end
end
