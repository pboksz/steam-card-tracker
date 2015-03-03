class DefaultRepository
  attr_reader :klass

  def initialize(klass)
    @klass = klass
  end

  def all
    klass.all
  end

  def new(attributes = {})
    klass.new(attributes)
  end

  def create(attributes = {})
    klass.create(attributes)
  end

  def find_all(attributes)
    klass.where(attributes)
  end

  def find(attributes)
    find_all(attributes).first
  end

  def find_or_initialize(attributes)
    find_all(attributes).first_or_initialize
  end
end
