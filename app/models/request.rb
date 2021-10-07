class Request
  attr_accessor :from, :to, :status, :items_to_reward

  def initialize(from = nil, to = nil, status = "pendeing", items_to_reward = nil)
    @from = from
    @to = to
    @status = status
    @items_to_reward = items_to_reward
  end
end
