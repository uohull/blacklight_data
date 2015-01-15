# -*- encoding : utf-8 -*-
require 'blacklight/catalog'
require 'blacklight/field_configuration'

class CatalogController < ApplicationController  
  include Blacklight::Catalog

  before_action :configure, only: :index

  def configure
    # Configures Blacklight application fields for show/index/facet/sorts etc.
    BlacklightConfigurator.configure_blacklight 
  end
  
end 
