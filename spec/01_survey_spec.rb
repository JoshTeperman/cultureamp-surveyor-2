RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: 'Engagement Survey') }

  it 'has a name' do
    expect(subject.name).to eq('Engagement Survey')
  end

  it 'can have questions added' do
    question = double(:question)
    subject.add_question(question)
    expect(subject.questions).to include(question)
  end

  describe 'Responses' do
    responses = [
      Surveyor::Response.new(email: 'ohjosh@josh.com'),
      Surveyor::Response.new(email: 'josh@josh.com'),
      Surveyor::Response.new(email: 'wendy@wendy.com'),
    ]
    before(:each) do
      responses.each { |response| subject.add_response(response) }
    end

    it 'can have responses added' do
      response = double(:response)
      subject.add_response(response)
      expect(subject.responses).to include(response)
    end

    it 'can ask a survey what its responses are' do
      expect(subject.responses).to eq(responses)
    end

    describe 'Find User Response' do
      it 'can find responses by user email address' do
        expect(subject.find_user_response('wendy@wendy.com')).to eq(responses[2])
      end

      it 'will only return exact email matches' do
        expect(subject.find_user_response('josh@josh.com')).to eq(responses[1])
      end

      it "will return nil when a response isn't found" do
        expect(subject.find_user_response('user@user.com')).to eq(nil)
      end
    end

    describe 'User Responded?' do
      it 'will return true if the user has already submitted a response' do
        expect(subject.user_responded?('josh@josh.com')).to eq(true)
      end

      it 'will return false if the user has not submitted a response' do
        expect(subject.user_responded?('user@user.com')).to eq(false)
      end
    end

    describe 'Survey Response & Answer breakdown for Rating Questions' do
      # Seed a new RatingQuesiton:
      before(:each) do
        subject.responses.clear
        question = Surveyor::RatingQuestion.new(title: 'Sample Title')
        subject.add_question(question)

        # Seed Answers to RatingQuestion:
        answers = [1, 1, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5]
        new_answers = answers.map do |answer|
          Surveyor::Answer.new(question: question, value: answer)
        end

        # Seed Responses with above Answers and add to Survey:
        counter = 1
        new_answers.each do |answer|
          response = Surveyor::Response.new(email: "#{counter}@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          counter += 1
        end
      end

      describe 'Data seeded correctly' do
        it 'Survey should be seeded with 12 Responses' do
          expect(subject.responses.length).to eq(12)
        end

        it 'Question is a RatingQuestion' do
          expect(subject.questions.sample.class).to eq(Surveyor::RatingQuestion)
        end

        it 'Response emails are all unique' do
          emails = subject.responses.map(&:email)
          expect(emails.uniq.length).to eq(subject.responses.length)
        end
      end

      describe 'Count answers for a given question' do
        before(:each) do
          @sample_question = subject.questions.first
        end

        it 'is the expected question' do
          expect(@sample_question.title).to eq('Sample Title')
        end

        it 'method only counts answers to the target question' do
          question = Surveyor::RatingQuestion.new(title: 'Test Question')
          answer = Surveyor::Answer.new(question: question, value: 3)
          response = Surveyor::Response.new(email: "test@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          expect(subject.fetch_answers(@sample_question, 1, 2, 3, 4, 5).length).to eq(12)
        end

        it 'can handle zero answers' do
          question = Surveyor::RatingQuestion.new(title: 'Test Question')
          answer = Surveyor::Answer.new(question: question, value: 1)
          response = Surveyor::Response.new(email: "test@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          subject.add_question(question)
          expect(subject.fetch_answers(question, 2).length).to eq(0)
        end

        it "can handle a question that doesn't exist" do
          expect(subject.fetch_answers(double(:question), 1)).to eq("That question doesn't exist")
        end

        it 'can count answers with rating 1' do
          expect(subject.fetch_answers(@sample_question, 1).length).to eq(3)
        end

        it 'can count answers with rating 2' do
          expect(subject.fetch_answers(@sample_question, 2).length).to eq(1)
        end

        it 'can count answers with rating 3' do
          expect(subject.fetch_answers(@sample_question, 3).length).to eq(2)
        end

        it 'can count answers with rating 4' do
          expect(subject.fetch_answers(@sample_question, 4).length).to eq(2)
        end

        it 'can count answers with rating 5' do
          expect(subject.fetch_answers(@sample_question, 5).length).to eq(4)
        end

        it 'can count low answers' do
          expect(subject.fetch_low_answers(@sample_question).length).to eq(4)
        end

        it 'can count neutral answers' do
          expect(subject.fetch_neutral_answers(@sample_question).length).to eq(2)
        end

        it 'can count high answers' do
          expect(subject.fetch_high_answers(@sample_question).length).to eq(6)
        end

        describe 'Break down answers for a given question' do
          it 'display selected answers in the correct format' do
            expect(subject.display_answers(@sample_question, 1, 2, 3)).to eq("1: 3\n2: 1\n3: 2")
          end

          it 'display all answers in the correct format' do
            expect(subject.display_all_answers(@sample_question)).to eq("1: 3\n2: 1\n3: 2\n4: 2\n5: 4")
          end

          it "can handle a question that doesn't exist" do
            expect(subject.display_answers(double(:question))).to eq("That question doesn't exist")
          end

          it 'handles displaying zero when a requested answer count has no results' do
            question = Surveyor::RatingQuestion.new(title: 'Test Question')
            answer = Surveyor::Answer.new(question: question, value: 1)
            response = Surveyor::Response.new(email: "test@gmail.com")
            response.add_answer(answer)
            subject.add_response(response)
            subject.add_question(question)
            expect(subject.display_answers(question, 2)).to eq("2: 0")
          end
        end
      end
    end

    describe 'Survey Response & Answer breakdown for Free Text Questions' do
      # Seed a new FreeTextQuesiton:
      before(:each) do
        subject.responses.clear
        question = Surveyor::FreeTextQuestion.new(title: 'Sample Title')
        subject.add_question(question)

        # Seed Answers to FreeTextQuestion:
        answers = [
          'aaaa',
          'aaaa',
          'aaaa',
          'bbbb',
          'cccc',
          'cccc',
          'dddd',
          'dddd',
          'eeee',
          'eeee',
          'eeee',
          'eeee',
        ]
        new_answers = answers.map do |answer|
          Surveyor::Answer.new(question: question, value: answer)
        end

        # Seed Responses with above Answers and add to Survey:
        counter = 1
        new_answers.each do |answer|
          response = Surveyor::Response.new(email: "#{counter}@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          counter += 1
        end
      end

      describe 'Data seeded correctly' do
        it 'Survey should be seeded with 12 Responses' do
          expect(subject.responses.length).to eq(12)
        end

        it 'Question is a RatingQuestion' do
          expect(subject.questions.sample.class).to eq(Surveyor::FreeTextQuestion)
        end

        it 'Response emails are all unique' do
          emails = subject.responses.map(&:email)
          expect(emails.uniq.length).to eq(subject.responses.length)
        end
      end

      describe 'Count answers for a given question' do
        before(:each) do
          @sample_question = subject.questions.first
        end

        it 'is the expected question' do
          expect(@sample_question.title).to eq('Sample Title')
        end

        it 'method only counts answers to the target question' do
          question = Surveyor::FreeTextQuestion.new(title: 'Test Question')
          answer = Surveyor::Answer.new(question: question, value: 'Test Answer')
          response = Surveyor::Response.new(email: "test@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          expect(subject.fetch_answers(@sample_question, 'aaaa', 'bbbb', 'cccc', 'dddd', 'eeee').length).to eq(12)
        end

        it 'can handle zero answers' do
          question = Surveyor::FreeTextQuestion.new(title: 'Test Question')
          answer = Surveyor::Answer.new(question: question, value: 'Test Answer')
          response = Surveyor::Response.new(email: "test@gmail.com")
          response.add_answer(answer)
          subject.add_response(response)
          subject.add_question(question)
          expect(subject.fetch_answers(question, 'bbbb').length).to eq(0)
        end

        it "can handle a question that doesn't exist" do
          expect(subject.fetch_answers(double(:question), 'Test Answer')).to eq("That question doesn't exist")
        end

        it 'can count a specific answer to a question' do
          expect(subject.fetch_answers(@sample_question, 'aaaa').length).to eq(3)
        end

        it 'can count multiple specific answers to a question' do
          expect(subject.fetch_answers(@sample_question, 'aaaa', 'bbbb').length).to eq(4)
        end

        describe 'Break down answers for a given question' do
          it 'display selected answers in the correct format' do
            expect(subject.display_answers(@sample_question, 'aaaa', 'bbbb', 'cccc')).to eq("aaaa: 3\nbbbb: 1\ncccc: 2")
          end

          it 'display all answers in the correct format' do
            expect(subject.display_all_answers(@sample_question)).to eq("aaaa: 3\nbbbb: 1\ncccc: 2\ndddd: 2\neeee: 4")
          end

          it "can handle a question that doesn't exist" do
            expect(subject.display_answers(double(:question))).to eq("That question doesn't exist")
          end

          it 'handles displaying zero when a requested answer count has no results' do
            question = Surveyor::FreeTextQuestion.new(title: 'Test Question')
            answer = Surveyor::Answer.new(question: question, value: 'Test Answer')
            response = Surveyor::Response.new(email: "test@gmail.com")
            response.add_answer(answer)
            subject.add_response(response)
            subject.add_question(question)
            expect(subject.display_answers(question, 'Another Test Answer')).to eq("Another Test Answer: 0")
          end
        end
      end
    end
  end
end
