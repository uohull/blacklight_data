class DatasetHeaderPropsController < ApplicationController
  before_action :set_dataset_header_prop, only: [:show, :edit, :update, :destroy]

  # GET /dataset_header_props
  # GET /dataset_header_props.json
  def index
    @dataset = Dataset.find( params[:dataset_id] )
    @dataset_header_props = @dataset.get_dataset_header_props
  end

  # GET /dataset_header_props/1
  # GET /dataset_header_props/1.json
  def show
  end

  # GET /dataset_header_props/new
  def new
    @dataset_header_prop = DatasetHeaderProp.new
  end

  # GET /dataset_header_props/1/edit
  def edit
  end

  # POST /dataset_header_props
  # POST /dataset_header_props.json
  def create
    @dataset_header_prop = DatasetHeaderProp.new(dataset_header_prop_params)

    respond_to do |format|
      if @dataset_header_prop.save
        format.html { redirect_to @dataset_header_prop, notice: 'Dataset header prop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dataset_header_prop }
      else
        format.html { render action: 'new' }
        format.json { render json: @dataset_header_prop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dataset_header_props/1
  # PATCH/PUT /dataset_header_props/1.json
  def update
    respond_to do |format|
      if @dataset_header_prop.update(dataset_header_prop_params)
        format.html { render action: 'edit', notice: 'Dataset header prop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dataset_header_prop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataset_header_props/1
  # DELETE /dataset_header_props/1.json
  def destroy
    @dataset_header_prop.destroy
    respond_to do |format|
      format.html { redirect_to dataset_header_props_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dataset_header_prop
      @dataset_header_prop = DatasetHeaderProp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dataset_header_prop_params
      params.require(:dataset_header_prop).permit(:searchable, :displayable, :facetable, :sortable, :multivalued, :dataset_id)
    end
end
