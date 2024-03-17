# frozen_string_literal: true

module Api
  module V1
    class ListingsController < ApplicationController
      include ListingHelper # TODO: implement service objects later

      before_action :authenticate_user!, except: :show
      before_action :user_must_be_proprietor, only: %i[create update]

      def show
        @listing = Listing.find(params[:id])

        image_urls = lising_image_urls(@listing)
        render json: { success: true, listing: @listing.as_json.except('images').merge(image_urls) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Listing not found' }, status: :not_found
      end

      def create
        @listing = current_user.listings.build(listing_params)

        if @listing.save

          image_urls = lising_image_urls(@listing)
          render json: { success: true, listing: @listing.as_json.except('images').merge(image_urls) }, status: :created
        else
          render json: @listing.errors, status: :unprocessable_entity
        end
      end

      def update
        @listing = Listing.find(params[:id])

        if @listing&.update(listing_params)

          image_urls = lising_image_urls(@listing)
          render json: { success: true, listing: @listing.as_json.except('images').merge(image_urls) }, status: :ok
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
    end
  end
end
