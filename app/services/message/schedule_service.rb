require 'rufus-scheduler'
require 'date'

module Message
  class ScheduleService

    def initialize(params)
      @message = params['message-original']
      @date = params['date']
      @timezone = params['timezone-original']
      @scheduler = Rufus::Scheduler.new
      @client = HTTPClient.new
    end

    def formatDate
      @date = (Time.parse(@date))
      @timezone = @timezone.to_i
      @date = @date - @timezone.hours
      @date = @date.strftime("%y/%m/%d %H:%M:%S")
    end

    def call
      return 'Mensagem obrigatória' if @message == nil || @message == ''
      return 'Data obrigatória' if @date == nil || @date == ''
      return 'Fuso obrigatório' if @timezone == nil || @timezone == ''

      begin
        formatDate
        @scheduler.at @date do
          @client.post("https://hooks.slack.com/services/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",
          {:text => "#{@message}"}.to_json)
        end
        "A Mensagem será enviada em: #{@date}"
      rescue
        'Problema no agendamento'
      end
    end
  end
end
