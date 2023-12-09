# frozen_string_literal: true

class LogMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "Running #{self.class.name} with arguments: #{args.inspect}"
  end
end
