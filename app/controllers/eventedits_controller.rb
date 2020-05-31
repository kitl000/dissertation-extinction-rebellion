class EventeditsController < ApplicationController
  before_action :set_eventedit, only: [:show, :edit, :update, :destroy]

  # GET /eventedits
  # GET /eventedits.json
  def index
    @eventedits = Eventedit.all
  end

  # GET /eventedits/1
  # GET /eventedits/1.json
  def show
  end

  # GET /eventedits/new
  def new
    @eventedit = Eventedit.new
  end

  # GET /eventedits/1/edit
  def edit
  end

  # POST /eventedits
  # POST /eventedits.json
  def create
    @existingEventEdit = Eventedit.find_by(fbid: eventedit_params['fbid'])

    if @existingEventEdit != nil
      @existingEventEdit.update(eventedit_params)
      @eventedit = @existingEventEdit
    else
      @eventedit = Eventedit.create(eventedit_params)
    end

    respond_to do |format|
      @event = Event.find_by(fbid: @eventedit.fbid)
      if @eventedit.save
        format.html { redirect_to @event, notice: 'Event information successfully updated' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @eventedit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventedits/1
  # PATCH/PUT /eventedits/1.json
  def update
    respond_to do |format|
      if @eventedit.update(eventedit_params)
        format.html { redirect_to @eventedit, notice: 'Event information successfully updated' }
        format.json { render :show, status: :ok, location: @eventedit }
      else
        format.html { render :edit }
        format.json { render json: @eventedit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventedits/1
  # DELETE /eventedits/1.json
  def destroy
    @eventedit.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event information removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eventedit
      @eventedit = Eventedit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def eventedit_params
      params.require(:eventedit).permit(:id,
          :fbid, :title, :image, :start_time, :end_time, :description, :lat, :long, :street, :zip, :city, :category
      )
    end
end
