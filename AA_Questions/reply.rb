require_relative 'questionsdatabase'

class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(options) #options is a hash
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body= options['body']
  end

  def self.find_by_id(id)
    my_reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL
    return nil unless my_reply.length > 0
    Reply.new(my_reply.first)
  end

  def self.find_by_user_id(user_id)
    arr = []
    my_reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies 
      WHERE user_id = ?
    SQL
    return nil unless my_reply.length > 0
    my_reply.each do |reply|
      arr << Reply.new(reply)
    end
    arr
  end

  def self.find_by_question_id(question_id)
    arr = []
    my_reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies 
      WHERE question_id = ?
    SQL
    return nil unless my_reply.length > 0
    my_reply.each do |reply|
      arr << Reply.new(reply)
    end
    arr
  end
end

# p Reply.find_by_question_id(1)