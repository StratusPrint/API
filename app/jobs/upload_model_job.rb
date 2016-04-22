class UploadModelJob < ApplicationJob
  include ::CarrierWave::Workers::ProcessAssetMixin
  queue_as :default

  after_perform do
    # Upload model to printer inside here, along with any other
    # required computations.
  end

  # Sometimes job gets performed before the file is uploaded and ready.
  # You can define how to handle that case by overriding `when_not_ready` method
  # (by default it does nothing)
  def when_not_ready
    retry_job
  end
end
