require_relative 'questionsdatabase'

class QuestionLike
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options) #options is a hash
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    my_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL
    return nil unless my_like.length > 0
    QuestionLike.new(my_like.first)
  end
end

p QuestionLike.find_by_id(1)