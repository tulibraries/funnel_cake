# frozen_string_literal: true

Rails.application.routes.draw do

  mount Blacklight::Engine => "/"
  root to: "catalog#index"

  concern :searchable, Blacklight::Routes::Searchable.new

  get :oai, to: "dpla_oai#oai"
  get :oai_dev, to: "internal_oai#oai"


  scope id: /([^\/]+?)(?=\.json|\.xml|$|\/)/ do
    resource :catalog, only: [:index], as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
    end
    concern :exportable, Blacklight::Routes::Exportable.new

    resources :solr_documents, only: [:show], path: "/catalog", controller: "catalog" do
      concerns :exportable
    end
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete "clear"
    end
  end

  get "csv" => "csv#index"
end
