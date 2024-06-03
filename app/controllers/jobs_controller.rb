class JobsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @job = Job.new(job_params)
    if @job.save
      render json: @job, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def show
    @job = Job.find(params[:id])
    render json: @job
  end

  def index
    @jobs = Job.all
    render json: @jobs
  end

  private

  def job_params
    params.require(:job).permit(
      :url,
      :employer_name,
      :employer_description,
      :job_title,
      :job_description,
      :years_of_experience,
      :education_requirement,
      :industry,
      :base_salary,
      :employment_type_id
    )
  end
end
