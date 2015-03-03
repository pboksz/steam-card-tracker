class ListingRequester
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def response
    parser.parse(requester.body)
  end

  private

  def parser
    @parser ||= JSON
  end

  def request_uri
    @request_uri ||= URI(request)
  end

  def requester
    @requester ||= Net::HTTP.get_response(request_uri)
  end
end
