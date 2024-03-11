# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      before_action :authenticate_user!, except: :show
      # TODO: Investigate why this is failing
      # before_action :user_must_be_proprietor, only: %i[create update]
      include UnitHelper

      def show
        @unit ||= Unit.find(params[:id])
        image_urls = unit_image_urls(@unit)

        render json: {
          success: true,
          unit: @unit.as_json.except('images').merge(image_urls)
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Unit not found' }, status: :not_found
      end

      def create
        # FIXME: we might offload the entire unit creation process into a job
        @unit = Unit.new(unit_params)
        if @unit.save
          image_urls = unit_image_urls(@unit)
          render json: { success: true, unit: @unit.as_json.except('images').merge(image_urls) }, status: :created
        else
          render json: { error: @unit.errors, status: :unprocessable_entity }
        end
      end

      def update
        @unit ||= Unit.find(params[:id])

        if @unit&.update(unit_params)
          render json: { success: true, unit: @unit }, status: :ok
        else
          render json: @unit.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: 'Unit not found' }, status: :not_found
      end

      def assign_unit_to_occupant
        # TODO: Figure out what this POST path should do
        # NOTE: 1
        # update fields assigned_by_id, assignted_at, is_available, user_id
        # user_id should be currently signed user who should be an occupant
        # how do we track assigned by id?
        # NOTE: 2
        # we have to make sure that this request coming after qr code scanning or link click, is coming from a user page
        # in which user has accepted terms of service and is registered on the platform.
        # NOTE: 3
        # perhaps send an email to them with details of the unit

        render json: { success: true }, status: :ok
      end

      private

      def unit_params
                      params.permit(:id, :size, :amount, :identifier, :description, :availability_date, :bathroom_count,
                      :full_bathroom_count, :is_available, :unit_type, :unit_lease_type, :listing_id, :qrcode,
                      :floorplan_image, images: [])
      end

    end
  end
end
