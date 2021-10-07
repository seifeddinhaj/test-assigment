module Validators
  class Input
    include ActiveModel::Model

    KEY_WORDS = ["accepts", "recommends"].freeze
    DATE_LENGTH = 16

    attr_accessor :data

    validates :data, presence: true

    validate :validate_input

    def initialize(data)
      @data = data
    end

    private

    def validate_input
      return if errors.any?

      validate_by_row
      validate_date_order
    end

    def validate_date_order
      return if date_ordered?

      errors.add(:date, 'Please correct the date order')
    end

    def validate_by_row
      data.split("\n").each.with_index do |row, index|
        row.strip!
        validate_date(row, index)
        validate_keywords(row, index)
        validate_inviters(row, index)
      end
    end

    def dates_sequence
      data.split("\n").map do |row|
        strtime = row.strip.first(16)
        Time.zone.parse(strtime)
      end
    end

    def date_ordered?
      dates_sequence.map.with_index do |date, index|
        date <=> dates_sequence[index + 1]
      end.uniq.first.negative?
    end

    def validate_date(row, index)
      strtime = row.strip.first(16)
      Time.zone.parse(strtime)
    rescue ArgumentError
      errors.add(:date, "Date is invalid at #{index} line")
      throw(:abort)
    end

    def validate_keywords(row, index)
      return if KEY_WORDS.select do |keyword|
        row.downcase.include?(keyword)
      end.any?

      errors.add(:action, "Invitation is invalid at #{index} line")
      throw(:abort)
    end

    def validate_inviters(row, index)
      validate_recommends(row, index)
      validate_accepts(row, index)
    end

    def validate_recommends(row, index)
      return unless row.include?('recommends')
      return if inviter_found?(row)

      errors.add(:action, "Invalid inviter at #{index} line")
      throw(:abort)
    end

    def validate_accepts(row, index)
      return unless row.include?('accepts')
      return if no_inviter?(row)

      errors.add(:action, "Invalid inviter at #{index} line")
      throw(:abort)
    end

    def inviter_found?(row)
      action_index = row.index('recommends')
      row[action_index..-1].delete('recommends').gsub(/\s+/, '').present?
    end

    def no_inviter?(row)
      action_index = row.index('accepts')
      row[action_index..-1].delete('accepts').gsub(/\s+/, '').blank?
    end
  end
end

