class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = if current_user.Manager?
      current_user.projects.all
    else
      current_user.project_enrollment
    end

  end

  # GET /projects/1 or /projects/1.json
  def show

  end

  # GET /projects/new
  def new
    @project = current_user.projects.new
    authorize @project
  end

  # GET /projects/1/edit
  def edit
    authorize @project
  end
  

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.creator = current_user
    if params[:project][:users].any?
      params[:project][:users].reject!(&:empty?)
      @project.enrolled_user = User.find( params[:project][:users])
    end
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.'}
        format.json { render :show, status: :created, location: @project}
      else
        format.html { render :new}
        format.json { render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    authorize @project
    if params[:project][:users].any?
      params[:project][:users].reject!(&:empty?)
      @project.enrolled_user = User.find( params[:project][:users])
    end
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:project, {}).permit(:title , :description, :deadline ,:bugtype)
    end
end
