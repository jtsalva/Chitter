class Peep
  COLLECTION = 'peep'

  attr_reader :id
  attr_accessor :text, :author, :created_at

  def initialize(text:, author:, created_at: Store.timestamp, id: nil)
    @text = text
    @author = author
    @created_at = created_at
    @id = id
  end

  def self.all
    all = []
    Store.all(COLLECTION, order_by_creation: :desc) do |peep|
      all << Peep.new(
        text: peep[:text],
        author: peep[:author],
        created_at: peep[:created_at],
        id: peep.document_id
      )
    end

    all
  end

  def self.get(peep_id)
    peep = Store.get(COLLECTION, ref: peep_id)
    if peep.exists?
      Peep.new(
        text: peep[:text],
        author: peep[:author],
        created_at: peep[:created_at],
        id: peep.document_id)
    else
      nil
    end
  end

  def self.update(peep)
    Store.set(
     COLLECTION,
     ref: peep.id,
     text: peep.text,
     author: peep.author,
     created_at: peep.created_at
    )
  end

  def self.add(peep)
    Store.add(
      COLLECTION,
      text: peep.text,
      author: peep.author,
      created_at: peep.created_at
    )
  end

  def self.delete(peep)
    ref = if peep.is_a? Peep
            peep.id
          else
            # expecting peep id
            peep
          end

    Store.delete(COLLECTION, ref: ref)
  end

  def self.clear
    Store.delete(COLLECTION)
  end
end