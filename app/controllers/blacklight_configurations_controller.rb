class BlacklightConfigurationsController < ApplicationController
  before_action :set_blacklight_configuration, only: [:show, :edit, :update, :destroy, :edit_title, :update_title]

  # GET /blacklight_configurations
  # GET /blacklight_configurations.json
  def index
    #@dataset = Dataset.find( params[:dataset_id] )
    @blacklight_configurations = BlacklightConfiguration.order(:configuration)

    @title_configuration = BlacklightConfiguration.title_configuration
    @index_configurations = BlacklightConfiguration.all_index_configurations
    @show_configurations = BlacklightConfiguration.all_show_configurations
    @facet_configurations = BlacklightConfiguration.all_facet_configurations
    @search_configurations = BlacklightConfiguration.all_search_configurations
    @sort_configurations = BlacklightConfiguration.all_sort_configurations
  end

  # GET /blacklight_configurations/1
  # GET /blacklight_configurations/1.json
  def show
  end

  # GET /blacklight_configurations/1/edit
  def edit    
  end

  def edit_title
    # Return title compatible fields collection
    @title_compatible_fields = BlacklightConfiguration.all_title_compatible_fields
  end

  def update_title
    # inserting label parameter into the update_params (generated from a lookup)
    update_title_params = blacklight_configuration_params.merge({ "label" => field_label_from_solr_field})

    respond_to do |format|
      if @blacklight_configuration.update(update_title_params)
        format.html { redirect_to blacklight_configurations_url, notice: 'Blacklight configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blacklight_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blacklight_configurations/1
  # PATCH/PUT /blacklight_configurations/1.json
  def update
    respond_to do |format|
      if @blacklight_configuration.update(blacklight_configuration_params)
        format.html { redirect_to blacklight_configurations_url, notice: 'Blacklight configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blacklight_configuration.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklight_configuration
      @blacklight_configuration = BlacklightConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blacklight_configuration_params
      # For title update configuration we allow the change of the solr_field, for other updates we don't...
      if params[:action] == "update_title"
        params.require(:blacklight_configuration).permit(:solr_field)
      else
        params.require(:blacklight_configuration).permit(:label, :enabled)
      end
    end

    def field_label_from_solr_field
      solr_field = blacklight_configuration_params[:solr_field]
      # Look up the Label based upon the solr_field, and merge in with update params
      label = BlacklightConfiguration.all_title_compatible_fields[solr_field] unless solr_field.nil? 
    end
end
