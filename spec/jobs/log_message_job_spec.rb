# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogMessageJob do
  describe 'Queueing LogMessageJob' do
    context 'when testing LogMessageJob' do
      it 'enqueues a job with args' do
        expect { described_class.perform_later 'Initial job test' }.to enqueue_sidekiq_job.with('Initial job test')
      end
    end
  end
end
