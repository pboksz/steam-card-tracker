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

  def destroy(id)
    klass.destroy(id)
  end
end
