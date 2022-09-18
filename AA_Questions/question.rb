require_relative 'questionsdatabase'

class Question
  attr_accessor :id, :title, :body, :author_id

  def initialize(options) #options is a hash
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_id(id)
    my_question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions 
      WHERE id = ?
    SQL
    return nil unless my_question.length > 0
    Question.new(my_question.first)
  end

  def self.find_by_author_id(author_id)
    arr = []
    my_question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions 
      WHERE author_id = ?
    SQL
    return nil unless my_question.length > 0
    my_question.each do |question|
      arr << Question.new(question)
    end
    arr
  end

  def author
    
  end
end

# p Question.find_by_author_id(1)