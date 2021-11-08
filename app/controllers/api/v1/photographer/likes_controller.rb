module Api
  module V1
    module Photographer
      class LikesController < BasePhotographerController
        def create
          photo = Photo.find(params[:id])

          likes_updater = LikesUpdater.new(current_photographer, photo).like

          if likes_updater.success?
            render_data likes_updater.data
          else
            render_errors likes_updater.errors
          end
        end

        def destroy
          photo = Photo.find(params[:id])

          likes_updater = LikesUpdater.new(current_photographer, photo).unlike

          if likes_updater.success?
            render_data likes_updater.data
          else
            render_errors likes_updater.errors
          end
        end
      end
    end
  end
end
