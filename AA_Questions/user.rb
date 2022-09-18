require_relative 'questionsdatabase'
require_relative 'question'
require_relative 'reply'

class User
  attr_accessor :id, :fname, :lname 

  def initialize(options) #options is a hash
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    user_id = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM users 
      WHERE id = ?
    SQL
    return nil unless user_id.length > 0
    User.new(user_id.first)
  end

  def self.find_by_name(fname, lname)
    arr = []
    my_user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users 
      WHERE fname = ? AND lname = ?
    SQL
    return nil unless my_user.length > 0
    my_user.each do |name|
      arr << User.new(name)
    end
    arr
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end  
end

user = User.find_by_name('Katie', 'Han')[0]
p user.authored_replies