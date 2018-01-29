require_relative 'time_format_handler'

class App

  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new
    process_request
  end

  private

  def process_request
    case @request.path_info
    when /time/
      process_time_request
    else
      [404, headers, ["Not found\n"]]
    end

  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end

  def process_time_request
    if @request.params["format"]
      params = @request.params["format"].split(',')

      @time_format_handler = TimeFormatHandler.new
      body = @time_format_handler.params_handler(params)

      @response.status = @time_format_handler.success? ? 200 : 400
      [@response.status, headers, ["#{body}\n"]]
    else
      [400, headers, ["URL should have 'format' query string\n"]]
    end
  end

end
