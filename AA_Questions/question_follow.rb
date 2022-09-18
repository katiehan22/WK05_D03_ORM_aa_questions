require_relative 'questionsdatabase'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options) #options is a hash
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    follow_question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions_follows 
      WHERE id = ?
    SQL
    return nil unless follow_question.length > 0
    QuestionFollow.new(follow_question.first)
  end
end

p QuestionFollow.find_by_id(1)