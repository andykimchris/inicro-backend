# frozen_string_literal: true

module Api
  module V1
    class ListingController < ApplicationController
      before_action :authenticate_user!
      before_action :user_must_be_proprietor, only: %i[create update]

      def show
        @listing = Listing.find(params[:id])
        render json: { success: true, listing: @listing.as_json(include: :images) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end

      def create
        @listing = current_user.listings.build(listing_params)

        if @listing.save
          render json: { success: true,
                         listing: {
                           id: @listing.id,
                           title: @listing.title,
                           images: @listing.images.map { |image| url_for(image) }
                         } }, status: :created
        else
          render json: @listing.errors, status: :unprocessable_entity
        end
      end

      def update
        @listing = Listing.find(params[:id])

        if @listing&.update(listing_params)
          render json: { success: true, listing: @listing.as_json(include: :images) }, status: :ok
        else
          render json: @listing.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, error: 'Listing not found' }, status: :not_found
      end

      private

      def listing_params
        params.permit(:id, :title, :description, :size, :metadata, :floor_count, :site_link, :location_id, images: [])
      end

      def find_listing
        @listing = Listing.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end

      def user_must_be_proprietor
        return unless current_user && !current_user.is_proprietor

        render json: { error: 'Only proprietors can perform this action.' }, status: :forbidden
      end
    end
  end
end
