class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(tutorial_params)
    if @tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(@tutorial.id)
    else
      flash[:error] = 'Tutorial was not successfully created. ' + @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    Tutorial.destroy(params[:id])
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end
end
