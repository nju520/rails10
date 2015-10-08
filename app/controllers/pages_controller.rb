class PagesController < ApplicationController

  def welcome
  	@issues = Issue.all.reverse # 取出所有的活动信息，然后在首页显示
  end

  def about
  end
end
