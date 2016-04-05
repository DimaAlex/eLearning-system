class EstimationController < ApplicationController

	def create
		# @users_courses = UsersCourses.new(user_course_params)

		redirect_to :root_path, notice: 'Allo'

		# respond_to do |format|
		#   if @users_courses.save
		#     format.html { redirect_to course_pages_path(@course), notice: 'Course was successfully created.' }
		#     format.json { render :show, status: :created, location: @course }
		#   else
		#     format.html { render :new}
		#     format.json { render json: @course.errors, status: :unprocessable_entity }
		#   end
		# end
	end

	def user_course_params
		params.require(:user_course).permit(:user_id, :course_id, :estimation)
	end

end
