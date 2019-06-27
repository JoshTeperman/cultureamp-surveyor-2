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

    def fetch_answers(target_question, *args)
      return "That question doesn't exist" unless @questions.include?(target_question)

      answers = []
      @responses.each do |response|
        response.answers.each do |answer|
          if args.length.zero?
            answers.push(answer)
          elsif answer.question == target_question &&
                args.include?(answer.value)
            answers.push(answer)
          end
        end
      end
      answers
    end

    def fetch_low_answers(target_question)
      fetch_answers(target_question, 1, 2)
    end

    def fetch_neutral_answers(target_question)
      fetch_answers(target_question, 3)
    end

    def fetch_high_answers(target_question)
      fetch_answers(target_question, 4, 5)
    end

    def display_answers(target_question, *args)
      return "That question doesn't exist" unless @questions.include?(target_question)

      results = {}
      survey_answers = fetch_answers(target_question, *args).map(&:value)
      if args.length.zero?
        survey_answers.each do |answer|
          results[answer] = survey_answers.count(answer)
        end
      else
        args.each do |target_answer|
          results[target_answer] = survey_answers.count(target_answer)
        end
      end
      formatted_results = results.map do |answer, total|
        ["#{answer}: #{total}"]
      end
      formatted_results.join("\n")
    end

    def display_all_answers(target_question)
      display_answers(target_question)
    end
  end
end
