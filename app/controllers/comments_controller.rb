class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @bug = Bug.find(params[:bug_id])
    @comments = @bug.comments.all
  end
def new
  @comment.creator = current_user
end

  # GET /comments/1
  # GET /comments/1.json
  def show
    p params
  end

  # GET /comments/new
  # def
  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    pp comment_params
    @bug = Bug.find(params[:bug_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.bug = @bug
    authorize @comment
    respond_to do |format|
      if @comment.save
        format.js do
          @bug = Bug.find(params[:bug_id])

        end

        # format.html { redirect_to [@bug.project, @bug], notice: 'comment was successfully created.'}
        # format.json { render 'bugs/show', status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.'}
        format.json { render :show, status: :ok, location: @comment}
      else
        format.html { render :edit}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy

    @comment.destroy
    respond_to do |format|
      format.html {redirect_to [@project, @bug], notice: 'Comment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.find(params[:bug_id])
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :bug_id, :creator_id)
  end
end
