class Peep
  attr_reader :id
  attr_accessor :text, :author, :created_at

  def initialize(text:, author:, created_at:, id: nil)
    @text = text
    @author = author
    @created_at = created_at
    @id = id
  end
end