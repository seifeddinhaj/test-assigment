class Compute
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def calculate
    rendered_data = {}
    data = build_data()
    data.each do |item|
      rendered_data[item.name] = item.score
    end
    rendered_data
  end

  private

  def build_data
    requests = []
    rewards  = []
    items.each do |item|
      reward = Reward.new(item.from)
      if item.accepts? && requests.find {|req| req.to == item.from}&.status != "finished"
        rewards.push(reward)
        x = requests.find {|req| req.to == item.from}
        x.status = "accepted"
        x_reward = requests.find {|req| req.to == x.from}
        if  x_reward.present? && x_reward.items_to_reward.present?
          x.items_to_reward=   x.from + ',' + x_reward.items_to_reward
        else
          x.items_to_reward =  x.from
        end
        update_reward(requests, rewards)
      else
        if rewards.length == 0
          rewards.push(reward)
        end
        req = Request.new(item.from,item.to,"pending")
        requests.push(req)
      end
    end
    rewards.reject { |r| r.score == 0 }
  end

  def update_reward(requests, rewards)
    requests_to_award = requests.select {|req| req.status == "accepted"}
    requests_to_award.each do | item |
      item.status = "finished"
      compute_score(item.items_to_reward, rewards)
    end
  end

  def compute_score (items_to_reward, rewards)
    splitted_items = items_to_reward.split(",")
    splitted_items.each_with_index do |x, index|
      reward = rewards.find {|r| r.name == x}
      reward.score += 0.5 ** index
    end
  end
end
