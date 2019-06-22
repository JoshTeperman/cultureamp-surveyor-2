module Surveyor
  class Question
    attr_reader :title

    def initialize(hash)
      @title = hash[:title]
    end

  end
end