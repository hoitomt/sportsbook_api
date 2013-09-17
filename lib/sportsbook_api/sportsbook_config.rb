module SportsbookApi
  class SportsbookConfig
    def credentials
      @file = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/credentials.yml'))
    end

    def username
      credentials['username']
    end

    def password
      credentials['password']
    end
  end
end