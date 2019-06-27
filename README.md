# Surveyor - 2018 Culture Amp Junior Engineering Coding Test

## About
This is the 2018 technical challenge given to applicants to Culture Amp's Junior Engineering Program. 
I did this challenge in conjuction with the Toy Robot book (https://leanpub.com/toyrobot/) to learn testing in Ruby, in particular the RSpec Testing Suite. 

The challenge consisted of coding and writing tests for 'Surveyor', a CLI-based Ruby Gem that represents and validates survey data in Ruby. 

You are given a starter Gem with some boilerplate classes, a couple of beginner tests, and asked to build specific functionality coupled with tests that ensure the gem works as expected. 

## App Description & Design Decisions

You should be able to add responses to a survey, and also ask a survey what its responses are.

You should be able to ask an answer what its question is. It should not be possible to create an answer without specifying a question.

It is not necessary to link an answer to a survey. Instead, answers should be added to responses. You should be able to ask a response what its answers are.

Answers only know what questions they are answering. 

### Find a particular user's response by email

- Find a survey's response by the user's email address. If the response is not found, then the method will return `nil`.
- Check whether a user has responded to this survey yet, returns `true` or `false`.

### Find answers for a given question

The challenge instructions were to create a method that would count the number of high, neutral, and low answers to the rating question, and then create another method that would display the total answers for each value in a readable format. 

I initially wrote a method that would do exactly that, but decided to extend the code to flexibly allow for a search of any answer value for a given question:

```
~/lib/surveyor/survey.rb

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
```
The above method takes an instance of a Question Subclass as it's first argument, which in this challenge can be either `Surveyor::FreeTextQuestion` or `Surveyor::RatingQuestion`, but is intended to be useable with any future definition of a Question Subclass. 

The second argument `*args` allows a search for any number of answer values, and the method will return an array of all of the answers that match that value for the given question. 

If no answers are specified in the second argument, the method will skip the answer value validation check, and it will return every answer for the question.  

I chose to return an array of answer objects rather than the total number of answers. I thought this was a more extendable option as it still allows us to count answers by calling `.length` on the result of the method call, but in addition should allow for different features based off this data: for example you could add customer / respondent ID to the Answer object, giving you access to customer information etc etc, or add other variables that would allow for data analytics, all of which won't be possible if the method only returns the number of responses. 


This method gives us a baseline to flexibly search for different types of data: For example:

Find all answers: 
```
  fetch_answers(question)
```
Find all low answers (answer value 1 or 2), to be used with RatingQuestions:
```
  def fetch_low_answers(question)
    fetch_answers(question, 1, 2)
  end
```
Find answers with value 3 or 4:
```
  fetch_answers(question, 3, 4)
```
Find answers with a mixed group of values: 
```
  fetch_answers(question, 'Yes', 'No', 'Barbecue', 'something something something', 2, 100)
```

This method will be useable with any combination of Question types and validations, and can be coupled with tests and Question validations written ensure the responses are returning expected results. 

### Display answers for a given question

The challenge required a method that would break down the responses for a question by answer value, and display the totals in a readable format. For example:

```
answers = [1, 1, 2, 3, 3]
```
would return:

```
1: 2
2: 1
3: 3
```

I used the `fetch_answers(target_question, *args)` from earlier to retrieve the data, and wrote a new method that would format and display the results:

```
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
```

The method works in a similar way to the fetch_answers solution in that it takes an optional *args argument which allows a flexible search for different answer values. Once again you can search for any combination of Question Subclasses or Answer value types, as long as you configure the validations and tests as a safety net, and can be used to return all answers using an additional method:

```
~/lib/surveyor/survey.rb

def display_all_answers(target_question)
  display_answers(target_question)
end
```
Similarly to the `fetch_answers` method, when `*args` isn't specified, `*args.length` evaluates to zero and is caught by the if statement, which in turn counts all answers for the target question. 

Examples:

```
~/spec/01_survey_spec.rb

answers = [
          'aaaa',
          'aaaa',
          'aaaa',
          'bbbb',
          'cccc',
          'cccc',
        ]

it 'can count multiple specific answers to a question' do
  expect(subject.fetch_answers(@sample_question, 'aaaa', 'bbbb').length).to eq(4)
end

...

it 'display all answers in the correct format' do
  expect(subject.display_all_answers(@sample_question)).to eq("aaaa: 3\nbbbb: 1\ncccc: 2\ndddd: 2\neeee: 4")
end

...

it 'handles displaying zero when a requested answer count has no results' do
  question = Surveyor::FreeTextQuestion.new(title: 'Test Question')
  answer = Surveyor::Answer.new(question: question, value: 'Test Answer')
  response = Surveyor::Response.new(email: "test@gmail.com")
  response.add_answer(answer)
  subject.add_response(response)
  subject.add_question(question)
  expect(subject.display_answers(question, 'Another Test Answer')).to eq("Another Test Answer: 0")
end
```

## Testing

created data separately for different describe blocks to avoid different definitions and values corrupting other tests, also makes it easier to refactor one test block without breaking other tests

## Validation & Error Handling

I deviated from the instructions, which were to create a method to test whether an answer is valid and returns `true` or `false`. For Free Text Questions the instruction was that any String, even an empty string, would be valid. 

I chose to validate answers and throw custom errors rather than return true or false. I also chose not to allow empty strings or whitespace in this case. I fully understand that workin in a team environment taking reqests for features from Product or Senior Engineers, this kind of deviation without requesting permission would be unacceptable, yet in this case I was more interested in the challenge of adding extra validations and tests so that I could learn something new. 

My validation method is actually an instance method of the Question Subclass, and is called within the initialize function of the Answer class:

```
~/lib/surveyor/free_text_question.rb

class FreeTextQuestion < Question
  def validate_answer(answer_value)
    raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value.nil?
    raise ArgumentError, 'Invalid Answer: Answer value must be a String' if answer_value.class != String
    raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value.empty?
    raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value =~ /\A\s*\z/

    true
  end
end
```
```
~/lib/surveyor/answer.rb

def initialize(answer_hash)
  @question = answer_hash[:question]
  value = answer_hash[:value]
  @question.validate_answer(value)
  @value = value
end
```

I structured it this way so that when a new Answer is initialized, it will always call `@question.validate_answer(value)` and the validation will run as an instance method that references the Question Class which has it's own unique validation method. Answer knows nothing about what type of method or validation is being used on the answer value. This means it is possible to create new types of Question Subclass with their own validations, increasing the maintainability and extendability of the code. 


### Initializing Class Instances:
```
$~/lib/surveyor/question.rb

class Question
    attr_reader :title

    def initialize(question_hash)
      title = question_hash[:title]
      validate_title(title)
      @title = title
    end
...

$~/lib/surveyor/answer.rb

class Answer
    attr_reader :question, :value

    def initialize(answer_hash)
      @question = answer_hash[:question]
      value = answer_hash[:value]
      @question.validate_answer(value)
      @value = value
    end
...
```
I wasn't happy with the readability of these initialize methods, but I couldn't think of a better solution.  I typically prefer to group `@attribute = attribute` declarations together to make it clear what attributes are being initialized, and what functions are being called. However, it was necessary to validate the title & answer value before initializing them as instace attributes. 

I also could have called `validate_title(question_hash[:title])` in the Question Class directly without saving it to a variable first, but then I would have had to do so for every guard clause which felt even messier. The same can be said for the validation call in the Answer Class.

I wasn't certain whether I should initialize Class Instances using a hash or not. I was forced to to make the initial tests pass, but wasn't sure if it was a good design choice. Initially I felt it wasn't necessary as `Question.new(title: 'Sample Title)` is more complicated than `Question.new('Sample Title)`, when the latter could be initialized with `@title = title` without worrying about using the hash key. However, I found that using key / value pairs to initialize instances makes the code much more readable. For example, the first example in the snippet below makes it explicit what each argument refers to, where as the second example could be misinterpreted.
```
eg1: Answer.new(question: 'Sample Question', value: `Sample Value`)

eg2: Answer.new(`Sample Question', `Sample Value)
```


## Setup

For this coding test, you will first need to have Ruby 2.5 installed on your machine.

You will also need Bundler installed:

```
gem install bundler
```

Once you have Ruby + Bundler installed, you can install the gem dependencies for this test with this command:

```
bundle install
```

This will install the dependencies

You can verify that the code matches the Ruby Style Guide and what's configured in `.rubocop.yml` by running:

```
bundle exec rubocop
```

To view the tests and see if anything is failing run `bundle exec rspec`.

## Module Structure

### `Surveyor` Module

### `Surveyor::Survey` Class
`:name`<br>
`:questions`<br>
`:responses`

### `Surveyor::Question` Class
`:title` 

Questions are included on a survey to give the people doing a survey something to answer. There is a top-level class called `Question` which acts as a superclass to all other question classes. There are two other question classes: `RatingQuestion` and `FreeTextQuestion`. These both inherit from the `Question` class:

#### `Surveyor::RatingQuestion < Question` Class
Rating questions are those questions that could have answers between 1 and 5. 

#### `Surveyor::FreeTextQuestion < Question` Class
Free text questions have answers that are text-based.

### `Surveyor::Response` Class

`:answers` (array of Answer instances)<br>
A response will include a particular person's answers to the survey's questions. Responses are included on a survey as a way of tracking a particular person's response to a survey. 

`:email`<br>
Attribute that tracks the email address of the user who has submitted the response.

### `Surveyor::Answer` Class

Answers are included on a response to track what a particular person's answers were to questions on a survey. Answers are added to and therefore linked to responses, which are in turn linked to a Survey. Therefore you can ask a response what answers it has, but an Answer only knows what question it is answering. 

`:question`<br>
Tells you what Question the Answer is answering for the current survey.

`:value`<br>
Represents the actual answer value for the question that has been submitted by the user.





* Strong adherence to the [ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)
* Clean & simple Ruby code in `lib`
* Tests in the `spec` directory to cover what your gem does

