class ListingsRequester
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def response
    parse_request
  end

  private

  def requester
    @requester ||= Weary::Request.new(request)
  end

  def request_body
    @request_body ||= requester.perform.body
  end

  def parse_request
    @parse_request ||= JSON.parse(request_body)
  end
end
