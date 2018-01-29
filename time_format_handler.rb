class TimeFormatHandler

  FORMATS = { "year" => { :value => "%Y", :order => 0 }, "month" => { :value => "%m", :order => 1 },
              "day" => { :value => "%d", :order => 2 }, "hour" => { :value => "%H", :order => 3 },
              "minute" => { :value => "%M", :order => 4 }, "second" => { :value => "%S",:order => 5 } }.freeze

  def initialize
    @output = ""
    @wrong_output = []
  end

  def params_handler(params)
    time_now = []
    params.each do |param|
      FORMATS[param] ? time_now[FORMATS[param][:order]] = FORMATS[param][:value] : @wrong_output << param
    end

    if @wrong_output.empty?
      @output = Time.now.strftime(time_now.join('-'))
    else
      @output = "Unknown time format #{@wrong_output}"
    end
  end

  def success?
    @wrong_output.empty?
  end

end
