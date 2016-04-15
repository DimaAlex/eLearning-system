class EstimationController < ApplicationController

	def create
		redirect_to :root_path, notice: 'Allo'

	end

	def user_course_params
		params.require(:user_course).permit(:user_id, :course_id, :estimation)
	end

end
