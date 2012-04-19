module PagSeguro
  @@config = nil

  def self.config_file
    Rails.root.join("config/pagseguro.yml")
  end

  def self.config?
    File.exist?(config_file)
  end

  def self.config
    raise MissingConfigurationError, "file not found on #{config_file.inspect}" unless config?

    # load file if is not loaded yet
    @@config ||= YAML.load_file(config_file)

    # raise an exception if the environment hasn't been set
    # or if file is empty
    if @@config == false || !@@config[Rails.env]
      raise MissingEnvironmentError, ":#{Rails.env} environment not set on #{config_file.inspect}"
    end

    # retrieve the environment settings
    @@config[Rails.env]
  end

  class MissingEnvironmentError < StandardError; end
  class MissingConfigurationError < StandardError; end
end
