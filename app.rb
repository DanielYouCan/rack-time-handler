require_relative 'time_format_handler'

class App
  attr_accessor :status
  attr_accessor :response

  def call(env)
    req = Rack::Request.new(env)
    params(req)
    request(req)
  end

  private

  def request(req)
    case req.path_info
    when /time/
      @status = @time_format_handler.wrong_output.empty? ? 200 : 400
      [@status, headers, body]
    else
      [404, headers, ["Not found\n"]]
    end

  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end

  def params(req)
    params = req.params["format"].split(',')

    @time_format_handler = TimeFormatHandler.new
    @response = @time_format_handler.params_handler(params)
  end

  def body
    ["#{@response}\n"]
  end

end
