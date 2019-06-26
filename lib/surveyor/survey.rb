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

    def count_answers(target_question, *args)
      return "That question doesn't exist" unless @questions.include?(target_question)

      total = 0
      @responses.each do |response|
        response.answers.each do |answer|
          if answer.question == target_question &&
             args.include?(answer.value)
            total += 1
          end
        end
      end
      total
    end

    def count_low_answers(target_question)
      count_answers(target_question, 1, 2)
    end

    def count_neutral_answers(target_question)
      count_answers(target_question, 3)
    end

    def count_high_answers(target_question)
      count_answers(target_question, 4, 5)
    end
  end
end

# ? Finding low / neutral / high answers

# Surveys should be able to tell us how many "low", "neutral" and "high" answers there are for a particular rating question. The different ratings are:

# Low: 1 or 2
# Neutral: 3
# High: 4 or 5
# Add a method that counts the low answers on a survey for a given question. Once you've got that working, do the same for both the neutral and high answers too.

# ? Answer breakdown

# Surveys should be able to give us a breakdown of the answers for a particular rating question. This breakdown should tell us the number of each answer there was for that rating question like:

# 1: 10
# 2: 41
# 3: 4
# 4: 13
# 5: 17
# In this example, there would be 10 answers for the rating question that had the value "1", 41 with the value "2" and so on.

# * Step 1
# Method to check for ratingQuestion class
# Method counts answers for a given question and answer
# Method counts low answers for a given question
# survey.count_low_answers(question) => num of low answers (Int)
# survey.count_neutral_answers(question) => num of neutral answers (Int)
# survey.count_high_answers(question) => num of high answers (Int)

# ... question = survey.selected_question
# ... answers = survey.responses.each(response.answers.answer to question) => array of answers to question
# ... low answers = count answers.map (|answer| return answer if answer.answer_value = low)
# ... total low answers = low_answers.length

# * TEST
# confirms question is RatingQuestion class
# returns only answers that are low / answers that are rated correctly
# returns the expected number of answers
# returns answers to the specified question
# Handles zero / nil
# Handles answer doesn't exist

# * Step 2
# Break down answers for given question
# ... count answer = 1 for given question (split up count_low_answers)
# ... count answer = 2 for given question

# * TEST
# Return the correct result
# Should equal total number of responses