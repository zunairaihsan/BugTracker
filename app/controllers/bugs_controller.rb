class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy ]

  # GET /bugs or /bugs.json
  def index
    @project = Project.find(params[:project_id])
    @bugs = @project.bugs
  end

  # GET /bugs/1 or /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new
    authorize @bug
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs or /bugs.json
  def create
    @project = Project.find(params[:project_id])
    form_data = bug_params
    @bug = @project.bugs.new(form_data)
    @bug.created_by = current_user
    respond_to do |format|
      if @bug.save
        format.html { redirect_to [@project,@bug], notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to [@project,@bug], notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to [@project,@bug], notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def pick
    @project = Project.find(params[:project_id].to_i)
    if @project
      @bug = @project.bugs.find(params[:id].to_i)
      if @bug
        if !(@bug.assigned_to_id?)
          @bug.assigned_to = current_user
          @bug.save
        end
      end
    end
    redirect_to [@project, @bug]
  end

  def drop
    @project = Project.find(params[:project_id].to_i)
    if @project
      @bug = @project.bugs.find(params[:id].to_i)
      if @bug
        if @bug.assigned_to == current_user
          @bug.assigned_to = nil
          @bug.save
        end
      end
    end
    redirect_to  [@project, @bug]
  end

  def status
    if params[:status].to_i >= 0 && params[:status].to_i <= 3
      @project = Project.find(params[:project_id])
      @bug = @project.bugs.find(params[:id])
      if @project && @bug
        @bug.status = params[:status].to_i
        @bug.save
      end
    end
    redirect_to  [@project, @bug]
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @project = Project.find(params[:project_id])
      @bug = Bug.find(params[:id])
     
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params[:bug][:bugtype] = params[:bug][:bugtype].to_i
     params.require(:bug).permit(:title, :description, :deadline, :bugtype ,:image)
    end
end
