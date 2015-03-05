class ListingsRequester
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def response
    parser.parse(request_body)
  end

  private

  def parser
    @parser ||= JSON
  end

  def requester
    @requester ||= Weary::Request.new(request)
  end

  def request_body
    requester.perform.body
  end
end
