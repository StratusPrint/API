require "rails_helper"

describe "Job Management", :type => :request do
  let!(:hubs) { create_list(:hub, 3) }
  let(:printer) { hubs.first.printers.first }
  let(:job) { hubs.first.printers.first.jobs.first }
  let(:new_job) { build :job }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:admin_auth_headers) { admin.create_new_auth_token }
  let(:user_auth_headers) { user.create_new_auth_token }
  let(:hub_auth_headers) { hubs.first.create_new_auth_token }

  context "GET /printers/:id/jobs" do
    it "should not return a list of jobs if not authenticated" do
      get v1_printer_jobs_path(printer.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return a list of jobs if authenticated as parent hub" do
      get v1_printer_jobs_path(printer.id), headers: hub_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(printer.jobs.length)
    end

    it "should not return a list of jobs if not authenticated as parent hub" do
      get v1_printer_jobs_path(hubs.second.printers.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a list of jobs if authenticated as user" do
      get v1_printer_jobs_path(printer.id), headers: user_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(printer.jobs.length)
    end

    it "should return a list of jobs if authenticated as admin" do
      get v1_printer_jobs_path(printer.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(printer.jobs.length)
    end
  end

  context "POST /printers/:id/jobs" do
    #it "should not add a new job if not authenticated" do
    #  post v1_printer_jobs_path(printer.id), :job => { :model => "data:application/stl;base64,R0lGODlhPQ==", :model_name => "test" }
    #  expect(response).to have_http_status(:unauthorized)
    #end

    #it "should add a new a job if authenticated as parent hub" do
    #  post v1_printer_jobs_path(printer.id), :model => "data:application/stl;base64,R0lGODlhPQ==", :model_name => "test", headers: hub_auth_headers
    #  expect(response).to have_http_status(:created)
    #  expect(response).to match_response_schema("job")
    #end

    #it "should not add a new a job if not authenticated as parent hub" do
    # post v1_printer_jobs_path(hubs.second.printers.first.id), :job => { :model => "data:application/stl;base64,R0lGODlhPQ==", :model_name => "test" }, headers: hub_auth_headers
    #  expect(response).to have_http_status(:forbidden)
    #end

    #it "should add a new job if authenticated as user" do
    #  post v1_printer_jobs_path(printer.id), :model => "data:application/stl;base64,R0lGODlhPQ==", :model_name => "test", headers: user_auth_headers
    #  expect(response).to have_http_status(:created)
    #  expect(response).to match_response_schema("job")
    #end

    #it "should add a new job if authenticated as admin" do
    #  post v1_printer_jobs_path(printer.id), :job => { :model => "data:application/stl;base64,R0lGODlhPQ==", :model_name => "test" }, headers: admin_auth_headers
    #  expect(response).to have_http_status(:created)
    #  expect(response).to match_response_schema("job")
    #end
  end

  context "DELETE /jobs/:id" do
    it "should not delete a job if not authenticated" do
      delete v1_job_path(job.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not delete a job if authenticated as hub" do
      delete v1_job_path(job.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not delete a job if authenticated as user" do
      delete v1_job_path(job.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should delete a job if authenticated as admin" do
      delete v1_job_path(job.id), headers: admin_auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end

  context "GET /jobs/:id" do
    it "should not return a job if not authenticated" do
      get v1_job_path(job.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return a job if authenticated as the parent hub" do
      get v1_job_path(job.id), headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("job")
    end

    it "should not return a job if not authenticated as the parent hub" do
      get v1_job_path(hubs.second.printers.first.jobs.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a job if authenticated as user" do
      get v1_job_path(job.id), headers: user_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("job")
    end

    it "should return a job if authenticated as admin" do
      get v1_job_path(job.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("job")
    end
  end

  context "PATCH /jobs/:id" do
    it "should not update a job if not authenticated" do
      patch v1_job_path(job.id), params: { job: new_job.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not update a job if not authenticated as the parent hub" do
      patch v1_job_path(hubs.second.printers.first.jobs.first.id), params: { job: new_job.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not update a job if not authenticated as parent hub" do
      patch v1_job_path(hubs.second.printers.first.jobs.first.id), params: { job: new_job.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not update a job if authenticated as user" do
      patch v1_job_path(job.id), params: { job: new_job.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a job if authenticated as the parent hub" do
      patch v1_job_path(job.id), params: { job: new_job.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("job")
    end

    it "should update a job if authenticated as admin" do
      patch v1_job_path(job.id), params: { job: new_job.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("job")
    end
  end
end
