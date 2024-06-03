require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  let(:valid_attributes) {
    {
      url: "http://example.com/job",
      employer_name: "Example Inc.",
      employer_description: "A company that does things.",
      job_title: "Software Developer",
      job_description: "Develop software.",
      years_of_experience: 3,
      education_requirement: "Bachelor's Degree",
      industry: "Tech",
      base_salary: 100000,
      employment_type_id: 1
    }
  }

  let(:invalid_attributes) {
    { url: nil, employer_name: nil }
  }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Job" do
        expect {
          post :create, params: { job: valid_attributes }
        }.to change(Job, :count).by(1)
      end

      it "renders a JSON response with the new job" do
        post :create, params: { job: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include("application/json")
        Rails.logger.info response.body # Print the response body for debugging
        json_response = JSON.parse(response.body)
        expect(json_response['job_title']).to eq(valid_attributes[:job_title])
      end
    end

    context "with invalid parameters" do
      it "does not create a new Job" do
        expect {
          post :create, params: { job: invalid_attributes }
        }.to change(Job, :count).by(0)
      end

      it "renders a JSON response with errors for the new job" do
        post :create, params: { job: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
        Rails.logger.info response.body # Print the response body for debugging
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('base_salary') # Check the actual error keys
      end
    end
  end

  describe "GET #show" do
    let!(:job) { Job.create! valid_attributes }

    it "returns a success response" do
      get :show, params: { id: job.to_param }
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
      Rails.logger.info response.body # Print the response body for debugging
      json_response = JSON.parse(response.body)
      expect(json_response['job_title']).to eq(job.job_title)
    end
  end

  describe "GET #index" do
    let!(:job) { Job.create! valid_attributes }

    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(response.content_type).to include("application/json")
      Rails.logger.info response.body # Print the response body for debugging
      json_response = JSON.parse(response.body)
      expect(json_response.first['job_title']).to eq(job.job_title)
    end
  end
end
