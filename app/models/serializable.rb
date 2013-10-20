module Serializable
  def serializable_hash(options={})
    options[:only] = options[:only].map do |only|
      self.aliased_fields[only.to_s]
    end

    serialized = super(options).map do |key, value|
      if aliased = self.aliased_fields.invert[key]
        value = aliased == 'id' ? value.to_s : value
        key = aliased
      end

      [key, value]
    end

    Hash[serialized]
  end
end
