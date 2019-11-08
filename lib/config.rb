require 'json'

class Config
  attr_reader :prod_credentials, :test_credentials, :prod_project_id, :test_project_id

  def initialize(path_to_config)
    config = JSON.parse(IO.read(path_to_config))

    @prod_credentials = config['prod_credentials']
    @test_credentials = config['test_credentials']
    @prod_project_id = config['prod_project_id']
    @test_project_id = config['test_project_id']
  end

  def init_test_credentials
    ENV['GOOGLE_APPLICATION_CREDENTIALS'] = @test_credentials
  end

  def init_prod_credentials
    ENV['GOOGLE_APPLICATION_CREDENTIALS'] = @prod_credentials
  end
end