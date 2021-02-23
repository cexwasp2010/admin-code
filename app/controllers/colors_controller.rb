class ColorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_color, only: %i[ show edit update destroy ]

  # GET /colors or /colors.json
  def index
    require 'rest-client'
    response = RestClient::Request.execute(method: :get, url: 'localhost:3001/colores',
                            headers: {page: params[:page], items: 9})
    if response.code == 200
      body = JSON.parse(response.body)
      @colors = body["data"]
      @page = body["page"]
    end
  end

  # GET /colors/1 or /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors or /colors.json
  def create
    respond_to do |format|
      require 'rest-client'
      response = RestClient.post('localhost:3001/colores/', color_params.as_json, {:Authorization => 'admin irizREhyoG6Ejwr4AcjsQME9'})
      if response.code == 200
        @color = JSON.parse(response.body)
        format.html { redirect_to @color, notice: "Color was successfully created." }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1 or /colors/1.json
  def update
    respond_to do |format|
      require 'rest-client'
      response = RestClient.put('localhost:3001/colores/'+@color.id.to_s, color_params.as_json, {:Authorization => 'admin irizREhyoG6Ejwr4AcjsQME9'})
      if response.code == 200
        @color = JSON.parse(response.body)

        format.html { redirect_to @color, notice: "Color was successfully updated." }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1 or /colors/1.json
  def destroy
    
    respond_to do |format|
      RestClient.delete 'localhost:3001/colores/'+@color.id.to_s, {:Authorization => 'admin irizREhyoG6Ejwr4AcjsQME9'}
      format.html { redirect_to colors_url, notice: "Color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = nil 
      require 'rest-client'
      # admin irizREhyoG6Ejwr4AcjsQME9
      response = RestClient::Request.execute(method: :get, url: 'localhost:3001/colores/'+params[:id],
                          headers: {Authorization: 'user vURjXbANsTEvaSf5vQ5GVg8h'})
      if response.code == 200
        # @color = JSON.parse(response.body).collect { |i| [i["name"], i["id"]] }
        @color = Color.new(JSON.parse(response.body))
      end
    end

    # Only allow a list of trusted parameters through.
    def color_params
      params.require(:color).permit(:name, :color, :pantone, :year)
    end
end
