class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name

  attribute :count do |object|
    object.count
  end
end
