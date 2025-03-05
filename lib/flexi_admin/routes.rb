# frozen_string_literal: true

module FlexiAdmin
  module Routes
    def self.extended(router)
      router.instance_eval do
        concern :resourceful do
          post :bulk_action, on: :collection
          get :datalist, on: :collection
          get :autocomplete, on: :collection
        end

        namespace :flexi_admin do
          resources :modals, only: [], controller: "controllers/modals" do
            get :show, on: :collection
          end
        end
      end
    end
  end
end
