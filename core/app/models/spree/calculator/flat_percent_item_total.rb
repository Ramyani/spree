require_dependency 'spree/calculator'

module Spree
  class Calculator::FlatPercentItemTotal < Calculator
    preference :flat_percent, :decimal, :default => 0

    attr_accessible :preferred_flat_percent

    def self.description
      I18n.t(:flat_percent)
    end

    def compute(object)
      return unless object.present? and object.line_items.present?
      item_total = object.line_items.map(&:amount).sum
      value = item_total * BigDecimal.new(self.preferred_flat_percent.to_s) / BigDecimal.new('100')
      value.round(2)
    end
  end
end
