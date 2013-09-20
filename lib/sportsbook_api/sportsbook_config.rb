module SportsbookApi
  class SportsbookConfig

    attr_accessor :username, :password

    def initialize(username, password)
      @username = username
      @password = password
    end

  end
end