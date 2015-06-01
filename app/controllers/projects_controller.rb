class ProjectsController < ApplicationController

  before_action :load_projects, only: :index
  load_and_authorize_resource # or load_resource; authorize_resource

  def create
    if @project.save
      flash[:success] = "Project was saved!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    if @project.update_attributes(update_params)
      flash[:success] = "Project was updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Project was deleted"
    else
      flash[:error] = "Cannot destroy project"
    end
    redirect_to root_path
  end

  private

  # if If there is no create_params or update_params method defined, 
  # CanCanCan will search for _params method – this is what we are using in our demo (project_params).
  # Lastly, CanCanCan will search for a method with a static name resource_params.
  #
  # def project_params
  #   params.require(:project).permit(:title, :ongoing)
  # end
  #
  def create_params
    params.require(:project).permit(:title, :ongoing)
  end

  def update_params
    params.require(:project).permit(:title, :ongoing)
  end

  def load_projects
    @projects = Project.accessible_by(current_ability).order("created_at DESC")
  end

end
