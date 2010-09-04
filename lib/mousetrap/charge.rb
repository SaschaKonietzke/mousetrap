module Mousetrap
  class Charge < Resource
    attr_accessor \
      :id,
      :code,
      :quantity,
      :created_at,
      :type,
      :amount,
      :description


    def initialize(hash = {})
      super(self.class.attributes_from_api(hash))
    end

    protected

    def self.plural_resource_name
      'charges'
    end

    def self.singular_resource_name
      'charge'
    end

    def attributes
      {
        :id           => id,
        :code         => code,
        :quantity     => quantity,
        :created_at   => created_at,
        :type         => type,
        :amount       => amount,
        :description  => description
      }
    end

    def self.attributes_from_api(attributes)
      {
        :id           => attributes['id'],
        :code         => attributes['code'],
        :quantity     => attributes['quantity'],
        :created_at   => attributes['createdDatetime'],
        :type         => attributes['type'],
        :amount       => attributes['eachAmount'],
        :description  => attributes['description']
      }
    end
  end
end