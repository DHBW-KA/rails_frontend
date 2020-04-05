class SystemController < ApplicationController
  def ajax
    @message = current_user.messages.new
  end

  def stimulus
    @message = current_user.messages.new
  end

  def vue
    @message = current_user.messages.new
  end

  def actioncable
    @message = current_user.messages.new
  end
end
