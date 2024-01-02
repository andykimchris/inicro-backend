# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      # FIXME: Render floorplan_image in UnitBlueprint

      before_action :authenticate_user!, except: :show
      before_action :user_must_be_proprietor, only: %i[create update]

      def show
        @unit ||= Unit.find(params[:id])
        render json: { success: true, unit:
                      UnitBlueprint.render_as_hash(
                        @unit,
                        root: :fields,
                        meta: {
                          images: @unit.image_urls(request.base_url)
                        }
                      ) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Unit not found' }, status: :not_found
      end

      def create
        @unit = Unit.new(unit_params)
        if @unit.save
          render json: { success: true, unit:
                        UnitBlueprint.render_as_hash(
                          @unit,
                          root: :fields,
                          meta: {
                            images: @unit.image_urls(request.base_url)
                          }
                        ) }, status: :created
        else
          render json: { error: @unit.errors, status: :unprocessable_entity }
        end
      end

      def update
        @unit ||= Unit.find(params[:id])

        if @unit&.update(unit_params)
          render json: { success: true, unit:
                        UnitBlueprint.render_as_hash(
                          @unit,
                          root: :fields,
                          meta: {
                            images: @unit.image_urls(request.base_url)
                          }
                        ) }, status: :ok
        else
          render json: @unit.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: 'Unit not found' }, status: :not_found
      end

      private

      def unit_params
        params.permit(:id, :size, :amount, :identifier, :description, :availability_date, :is_available,
                      :unit_type, :unit_lease_type, :listing_id, :floorplan_image, images: [])
      end

      def user_must_be_proprietor
        return if current_user&.is_proprietor

        render json: { error: 'Only proprietors can perform this action.' }, status: :forbidden
      end
    end
  end
end
