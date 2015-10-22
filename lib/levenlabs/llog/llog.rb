require 'logger'

module LLog
  class Logger < ::Logger
    def initialize(out = STDOUT, *rest)
      super(out, *rest)
      @formatter = proc do |level, datetime, progname, msg|
        "~ #{level.upcase} -- #{msg}\n"
      end
    end

    {
      "debug" => Logger::DEBUG,
      "info" => Logger::INFO,
      "warn" => Logger::WARN,
      "error" => Logger::ERROR,
      "fatal" => Logger::FATAL,
    }.each do |method, severity|
      define_method(method) do |msg, kv = nil, &block|
        self.kv(severity, msg, kv, &block)
      end
    end

    def kv(level, msg, kv, &block)
      if !block.nil?
        msg = block.call()
      end

      suffix = ""
      if kv.is_a? Hash and kv.size > 0 then
        suffix = " -- " + (kv.map do |k,v| "#{k}=#{v.inspect}" end.join(" "))
      end

      self.add(level, "#{msg}#{suffix}", &block)

      # The logger doesn't do this by default
      if level == Logger::FATAL
        exit! 1
      end
    end
  end
end
