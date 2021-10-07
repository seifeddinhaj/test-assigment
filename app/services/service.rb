class Service
  attr_reader :data, :validator, :errors, :calculator

  delegate :errors, :invalid?, to: :validator
  delegate :calculate, to: :calculator

  def initialize(data)
    @data = data
    @validator = Validators::Input.new(data)
    @formatter = Formatter.new(data)
    @calculator = Compute.new(@formatter.sorted_rows)
  end
end
