module Surveyor
  class Question
    attr_reader :title

    def initialize(question_hash)
      title = question_hash[:title]
      validate_title(title)
      @title = title
    end

    def validate_title(title)
      raise ArgumentError, 'Invalid Question: Title value cannot be empty' if title.nil?
      raise ArgumentError, 'Invalid Question: Title value must be a String' unless title.class == String
      raise ArgumentError, 'Invalid Question: Title value cannot be empty' if title.empty?
      raise ArgumentError, 'Invalid Question: Title value cannot be empty' if title =~ /\A\s*\z/
      raise ArgumentError, 'Invalid Question: Title value must be more than three characters long' unless title.length > 3

      true
    end
  end
end
