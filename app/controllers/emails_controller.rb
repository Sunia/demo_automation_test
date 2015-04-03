class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.json
  def create
    # Check for the listener.
    @listener = User.where(:email => params[:email][:listener_id]).first

    if @listener.nil?
      @listener = User.create(:email => params[:email][:listener_id], :password => Rails.application.secrets.default_password)
    end
    # Check for the Sender
    params[:email][:sender_ids] = [""]

    params[:sender_emails].each do |sender|
      @sender = User.where(:email => sender).first
  
      if @sender.nil?
        @sender = User.create(:email => sender, :password => Rails.application.secrets.default_password)
      end
      params[:email][:sender_ids] << @sender.id
    end
    params[:email][:listener_id] = @listener.id
    @email = Email.new(email_params)
    respond_to do |format|
      if @email.save
        EmailMailer.send_email(@email).deliver_now 
        format.html { redirect_to :back, notice: 'Email has sent to selected senders for replying the answer' }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def send_email
    EmailMailer.send_email(params[:email][:email]).deliver_now 
    flash[:notice] = "Email has sent"
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:question, :listener_id, :questioner_id, :sender_ids => [])
    end
end
