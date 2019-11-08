require_relative 'store'

class User
  COLLECTION = 'user'

  attr_reader :username, :name, :email

  def initialize(username:, name:, email:)
    @username = username
    @name = name
    @email = email
  end

  def self.all
    all = []
    Store.all(COLLECTION) do |user|
      all << User.new(
        username: user[:username],
        name: user[:name],
        email: user[:email]
      )
    end

    all
  end

  def self.get(username)
    user = Store.get(COLLECTION, ref: username)
    if user.exists?
      User.new(username: user[:username], name: user[:name], email: user[:email])
    else
      nil
    end
  end

  def self.update(user)
    set(user)
  end

  def self.add(user)
    set(user)
  end

  def self.set_password(user, password)
    Store.set(
        COLLECTION,
        ref: user.username,
        password: password
    )
  end

  def self.authenticate(username, password)
    user = Store.get(COLLECTION, ref: username)
    p user
    if user.exists? and user[:password] == password
      User.new(
        username: user[:username],
        name: user[:name],
        email: user[:email]
      )
    else
      nil
    end
  end

  def self.delete(user)
    ref = if user.is_a? User
            user.username
          else
            # expecting a username
            user
          end

    Store.delete(COLLECTION, ref: ref)
  end

  def self.set(user)
    Store.set(
        COLLECTION,
        ref: user.username,
        username: user.username,
        name: user.name,
        email: user.email
    )
  end

  def self.clear
    Store.delete(COLLECTION)
  end
end