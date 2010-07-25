class AnswerController < ActionController::Base
  def index
    respond_to do |format|
      @questions = Question.find(:all)
      format.html
    end
  end
end
