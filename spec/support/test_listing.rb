class TestListing
  def self.new
    Oga.parse_html(html).css('.market_listing_row_link').first
  end

  private

  def self.html
    <<-html
<a class="market_listing_row_link" href="/link">
  <div class="market_listing_row">
    <div class="market_listing_game_name">Game Trading Card</div>
    <div class="market_listing_item_name">Trading Card</div>
    <img src="image.jpg">
    <div class="market_table_value normal_price">
      <span class="normal_price">$0.10 USD</span>
      <span class="sale_price">$0.08 USD</span>
    </div>
  </div>
</a>
    html
  end
end
