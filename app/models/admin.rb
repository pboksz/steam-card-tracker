class Admin
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :e, as: :email, type: String
  field :p, as: :encrypted_password, type: String
end
