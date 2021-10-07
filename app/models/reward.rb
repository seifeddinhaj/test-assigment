class Reward
  attr_reader :name
  attr_accessor :score

  def initialize(name = nil, score = nil)
    @name = name
    @score = 0
  end
end
