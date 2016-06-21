class EmailersController < ApplicationController
  before_action :set_emailer, only: [:show, :edit, :update, :destroy]

  # GET /emailers
  # GET /emailers.json
  def index
    @emailers = Emailer.all
  end

  # GET /emailers/1
  # GET /emailers/1.json
  def show
  end

  # GET /emailers/new
  def new
    @emailer = Emailer.new
  end

  # GET /emailers/1/edit
  def edit
  end

  # POST /emailers
  # POST /emailers.json
  def create
    @emailer = Emailer.new(emailer_params)

    respond_to do |format|
      if @emailer.save
        mg_client = Mailgun::Client.new 'key-db14f54722316205aca3e4f312280020'
        message_params =  { 
          from: 'sirohi.prashant@tftus.com',
          to:   params[:emailer][:mail_to],
          subject: params[:emailer][:sub],
          text:    params[:emailer][:mail]
        }
        result = mg_client.send_message('sandbox8a13ebea6c1148e69e7e3341a68e0e2b.mailgun.org', message_params).to_h!
        format.html { redirect_to @emailer, notice: 'Emailer was successfully created.' }
        format.json { render :show, status: :created, location: @emailer }
      else
        format.html { render :new }
        format.json { render json: @emailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emailers/1
  # PATCH/PUT /emailers/1.json
  def update
    respond_to do |format|
      if @emailer.update(emailer_params)
        format.html { redirect_to @emailer, notice: 'Emailer was successfully updated.' }
        format.json { render :show, status: :ok, location: @emailer }
      else
        format.html { render :edit }
        format.json { render json: @emailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emailers/1
  # DELETE /emailers/1.json
  def destroy
    @emailer.destroy
    respond_to do |format|
      format.html { redirect_to emailers_url, notice: 'Emailer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emailer
      @emailer = Emailer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emailer_params
      params.fetch(:emailer).permit(:mail,:mail_to, :sub)
    end
end
