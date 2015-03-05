class Game
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :n, :as => :name, :type => String

  has_many :items, :dependent => :destroy

  validates :name, :uniqueness => true

  default_scope -> { order_by(:name => :asc) }

  def as_json(options = {})
    json_generator.generate
  end

  def as_full_json(options = {})
    json_generator.generate_full
  end

  private

  def json_generator
    @json_generator ||= JsonGenerator.new(self)
  end
end
