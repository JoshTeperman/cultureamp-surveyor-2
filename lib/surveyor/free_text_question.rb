module Surveyor
  class FreeTextQuestion < Question
    def valid_answer?(answer)
      answer.class == String
    end
  end
end