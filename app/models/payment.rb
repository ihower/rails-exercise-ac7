class Payment < ActiveRecord::Base

  serialize :params, JSON

  belongs_to :order

  before_validation :setup_amount
  after_update :update_order_status

  PAYMENT_METHODS = %w[Credit WebATM ATM] # CVS BARCODE
  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS

  validate :check_mac, on: :update

  def deadline
    Time.now + 7.days
  end

  def name
    "ALPHACamp AC6 Order: #{self.order.id}"
  end

  def email
    order.email
  end

  def external_id
    "#{self.id}AC#{Rails.env.upcase[0]}"
  end

  def self.find_and_process(params)
    result = JSON.parse( params['Result'] )

    payment = self.find(result['MerchantOrderNo'].to_i)
    payment.paid = params['Status'] == 'SUCCESS'
    payment.params = params
    payment
  end

  def parse_result
    JSON.parse( self.params['Result'] )
  end

  def check_mac
    pay2go = Pay2go.new(parse_result)
    errors.add(:params, 'wrong mac value') unless pay2go.check_mac
  end

  private

  def setup_amount
    self.amount = order.amount
  end

  def update_order_status
    if self.paid && !self.order.paid?
      order.paid = true
      order.save( :validate => false )
    end
  end


end
