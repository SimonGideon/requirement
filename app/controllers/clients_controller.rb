class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all.order(created_at: :desc)
  end

  def show
    @projects = @client.projects.order(created_at: :desc)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_path(@client), notice: "Client was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("client_form", partial: "clients/form", locals: { client: @client }) }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_path(@client), notice: "Client was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("client_form", partial: "clients/form", locals: { client: @client }) }
      end
    end
  end

  def destroy
    @client.destroy
    
    respond_to do |format|
      format.html { redirect_to clients_path, notice: "Client was successfully deleted." }
      format.turbo_stream
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :phone, :company, :notes)
  end
end