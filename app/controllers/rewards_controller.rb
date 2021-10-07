# frozen_string_literal: true

class RewardsController < ApplicationController
  def calculate_rewards
    service = Service.new(request.raw_post)
    return render json: { errors: service.errors }, status: :unprocessable_entity if service.invalid?

    render json: service.calculate, status: :ok
  end
end
