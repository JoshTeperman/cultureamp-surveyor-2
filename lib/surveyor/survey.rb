module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(survey_hash)
      @name = survey_hash[:name]
      @questions = []
      @responses = []
    end

    def add_question(question)
      @questions.push(question)
    end

    def add_response(response)
      @responses.push(response)
    end

    def find_user_response(email)
      @responses.find { |response| response.email =~ /\b#{email}\b/ }
    end

    def user_responded?(email)
      find_user_response(email) != nil
    end
  end
end

# Finding low / neutral / high answers

# Surveys should be able to tell us how many "low", "neutral" and "high" answers there are for a particular rating question. The different ratings are:

# Low: 1 or 2
# Neutral: 3
# High: 4 or 5
# Add a method that counts the low answers on a survey for a given question. Once you've got that working, do the same for both the neutral and high answers too.
