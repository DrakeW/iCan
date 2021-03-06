class DeltaLogger
  
  VALID_LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]

  def initialize(app, log_level)
    @app = app
    @log_level = VALID_LOG_LEVELS.include?(log_level)? log_level : :info
  end

  # for thread safety
  def call(env)
    dup._call(env)
  end

  def _call(env)
    request_started_on = Time.now
    @status, @headers, @response = @app.call env
    request_ended_on = Time.now

    Rails.logger.send(@log_level, "=" * 50)
    Rails.logger.send(@log_level, "Request delta time: #{request_ended_on - request_started_on} seconds.")
    Rails.logger.send(@log_level, "=" * 50)

    [@status, @headers, @response]
  end
end
