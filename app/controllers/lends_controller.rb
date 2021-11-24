class LendsController < ApplicationController
  before_action :set_lend, only: %i[ show edit update destroy ]

  # GET /lends or /lends.json
  def index
    @lends = Lend.all
  end

  # GET /lends/1 or /lends/1.json
  def show
    @lend = Lend.find(params[:id])
  end

  # GET /lends/new
  def new
    @lend = Lend.new
  end

  # GET /lends/1/edit
  def edit
    @lend = Lend.find(params[:id])
  end

  # POST /lends or /lends.json
  def create

    @lend = Lend.new

    if User.find_by(email: lend_params[:user_email]).nil?
      error = true
      @lend.errors[:base] << "Invalid email"
    else
      error = false
      user = User.find_by!(email: lend_params[:user_email])
      @lend.book_id = lend_params[:book_id]
      @lend.user_id = user.id
    end

    respond_to do |format|
      if !error && @lend.save
        format.html { redirect_to @lend, notice: 'Lend was successfully created.' }
        format.json { render :show, status: :created, location: @lend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lends/1 or /lends/1.json
  def update

    if User.find_by(email: lend_params[:user_email]).nil?
      error = true
      @lend.errors[:base] << 'Invalid email'
    else
      user = User.find_by!(email: lend_params[:user_email])
      @lend.user_id = user.id
      @lend.book_id = lend_params[:book_id]

      if lend_params[:returned_bool] == 'Yes'
        @lend.devolution = Time.new
      else
        @lend.devolution = nil
      end
    end

    respond_to do |format|
      if !error && @lend.save
        format.html { redirect_to @lend, notice: 'Lend was successfully updated.' }
        format.json { render :show, status: :ok, location: @lend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lends/1 or /lends/1.json
  def destroy
    @lend.destroy
    respond_to do |format|
      format.html { redirect_to lends_url, notice: 'Lend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lend
      @lend = Lend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lend_params
      params.fetch(:lend, {}).permit(:book_id, :user_email, :returned_bool)
    end
end
