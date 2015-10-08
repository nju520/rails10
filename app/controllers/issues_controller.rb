class IssuesController < ApplicationController

	def new
    if not current_user
      flash[:notice] = "没有执行此操作的权限，请先登录"
      redirect_to :root
    else
		  @issue = Issue.new
    end
	end

  def create
    @issue = Issue.create(issue_params)
    if @issue.save
      redirect_to :root
    end
  end
	
  def show
  	@issue = Issue.find(params[:id]) # Parameters: {"id"=>"2"}   # 这里获取的@issue 是给views中的 issues/show.html.erb使用的
    @comments = @issue.comments      #nice
    
  end

  def edit
    @issue = Issue.find(params[:id])     
  end

  def update
    issue = Issue.find(params[:id])
    issue.update_attributes(issue_params)
    redirect_to :root
  end

  def destroy
  	issue = Issue.find(params[:id])
  	issue.destroy
  	redirect_to :root
  end

  #strong parameters
  private
  def issue_params
    params.require(:issue).permit(:title, :content, :user_id)
  end
end
