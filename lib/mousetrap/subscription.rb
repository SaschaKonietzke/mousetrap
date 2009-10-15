module Mousetrap
  class Subscription < Resource
    # Attributes we send _to_ the API.
    attr_accessor \
      :plan_code,
      :billing_first_name,
      :billing_last_name,
      :credit_card_number,
      :credit_card_expiration_month,
      :credit_card_expiration_year,
      :billing_zip_code,
      :plan,

      :customer_code # belongs to customer

    # Attributes that come _from_ the API.
    attr_reader \
      :id,
      :canceled_at,
      :created_at,
      :credit_card_expiration_date,
      :credit_card_last_four_digits,
      :credit_card_type

    def self.[](code)
      raise NotImplementedError, API_UNSUPPORTED
    end

    def self.all
      raise NotImplementedError, API_UNSUPPORTED
    end

    def self.destroy_all
      raise NotImplementedError, API_UNSUPPORTED
    end

    def self.exists?(code)
      raise NotImplementedError, API_UNSUPPORTED
    end

    def attributes
      {
        :id                           => id,
        :plan_code                    => plan_code,
        :billing_first_name           => billing_first_name,
        :billing_last_name            => billing_last_name,
        :credit_card_number           => credit_card_number,
        :credit_card_expiration_month => credit_card_expiration_month,
        :credit_card_expiration_year  => credit_card_expiration_year,
        :billing_zip_code             => billing_zip_code,
      }
    end

    def attributes_for_api
      self.class.attributes_for_api(attributes)
    end

    def destroy
      raise NotImplementedError, API_UNSUPPORTED
    end

    def save
      mutated_attributes = attributes_for_api
      self.class.put_resource('customers', 'edit-subscription', customer_code, mutated_attributes)
    end

    def exists?
      raise NotImplementedError, API_UNSUPPORTED
    end

    def self.new_from_api(attributes)
      subscription = new(attributes_from_api(attributes))
      subscription.plan = Plan.new_from_api(attributes['plans']['plan'])
      subscription
    end

    protected

    attr_writer \
      :id,
      :canceled_at,
      :created_at,
      :credit_card_expiration_date,
      :credit_card_last_four_digits,
      :credit_card_type

    def self.plural_resource_name
      'subscriptions'
    end

    def self.singular_resource_name
      'subscription'
    end

    def self.attributes_for_api(attributes)
      {
        :planCode     => attributes[:plan_code],
        :ccFirstName  => attributes[:billing_first_name],
        :ccLastName   => attributes[:billing_last_name],
        :ccNumber     => attributes[:credit_card_number],
        :ccExpMonth   => "%02d" % attributes[:credit_card_expiration_month],
        :ccExpYear    => attributes[:credit_card_expiration_year],
        :ccZip        => attributes[:billing_zip_code],
      }
    end

    def self.attributes_from_api(attributes)
      {
        :id                           => attributes['id'],
        :canceled_at                  => attributes['canceledDatetime'],
        :created_at                   => attributes['createdDatetime'],
        :credit_card_expiration_date  => attributes['ccExpirationDate'],
        :credit_card_last_four_digits => attributes['ccLastFour'],
        :credit_card_type             => attributes['ccType'],
      }
    end
  end
end
