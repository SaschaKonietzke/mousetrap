module Mousetrap
  class Invoice < Resource
    attr_accessor \
      :id,
      :number,
      :billing_date,
      :created_at,
      :type,
      :paid_transaction_id,
      :charges
      
    def initialize(hash = {})
      super(self.class.attributes_from_api(hash))
    end

    protected

    def self.plural_resource_name
      'invoices'
    end

    def self.singular_resource_name
      'invoice'
    end

    def attributes
      {
        :id           => id,
        :number       => number,
        :billing_date => billing_date,
        :created_at   => created_at,
        :type         => type,
        :paid_transaction_id => paid_transaction_id,
        :charges      => charges
      }
    end

    def self.attributes_from_api(attributes)
      {
        :id           => attributes['id'],
        :number       => attributes['number'],
        :billing_date => Time.parse(attributes['billingDatetime']),
        :created_at   => Time.parse(attributes['createdDatetime']),
        :type         => attributes['type'],
        :paid_transaction_id => attributes['paidTransactionId'],
        :charges => attributes['charges']
      }
    end
  end
end