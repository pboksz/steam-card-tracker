class Game
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :n, as: :name, type: String
  field :u_at, as: :updated_at, type: Date

  has_many :items, dependent: :destroy

  validates :name, uniqueness: true

  default_scope -> { order_by(name: :asc) }

  def as_json(options = {})
    json_generator.generate
  end

  def as_full_json(options = {})
    json_generator.generate_full
  end

  def updated_today?
    updated_at == Date.today
  end

  private

  def json_generator
    @json_generator ||= GameJsonGenerator.new(self)
  end
end
