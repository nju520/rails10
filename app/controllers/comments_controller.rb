class CommentsController < ApplicationController
	def create
		#render plain: params.inspect
		@comment = Comment.new(comment_params) # 必须声明为实例变量，供后面显示评论使用－－－create.js.erb 中的
		# $(".replies").append("<%= escape_javascript render(partial: 'shared/comment', locals: {comment: @comment}) %>"); 最后将实例变量赋值给局部变量
		#c.username = params[:username]
		#c.email = params[:email]
		#c.content = params[:content]
		#c.issue_id = params[:issue_id]  # issue_id 这条参数在前端不好看出来，其实就是对应的那条评论的ID，在后端的rails server  一眼就可以看出来。
		@comment.save
		#issue = Issue.find(params[:issue_id])
		# 通过这条评论 可以直接找到对应的issue,真是太漂亮了这个主题
		#redirect_to c.issue
		respond_to do |format|
			format.js
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:issue_id, :user_id, :content)
	end



end
