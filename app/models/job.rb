class Job < ApplicationRecord
  swagger_schema :Job do
    key :required, [:id, :data]
    property :id do
      key :type, :integer
      key :description, 'The unique ID of the print job'
    end
    property :created_at do
      key :type, :string
      key :format, 'date-time'
      key :description, 'The time the print job was created by the hub'
    end
    property :updated_at do
      key :type, :string
      key :format, 'date-time'
      key :description, 'The time the print job was last updated by the hub'
    end
    property :created_by do
      key :type, :string
      key :format, 'date-time'
      key :description, 'The name of the user that created the job'
    end
    property :model do
      key :type, :string
      key :format, :byte
      key :description, 'The 3D model to print. Must be base64 encoded. Accepts *.stl and *.gcode extensions'
    end
    property :model_file_name do
      key :type, :string
      key :description, 'The file name of the 3D model'
    end
    property :model_file_url do
      key :type, :string
      key :description, 'A URL that can be used to download the model file associated with this job'
    end
    property :data do
      key :title, 'data'
      key :required, [:status, :started, :completed, :file, :origin, :size, :date, :filament, :progress]
      property :status do
        key :type, :string
        key :description, 'The current status of the print job'
        key :enum, ['processing', 'queued', 'completed', 'errored', 'slicing', 'printing', 'paused']
      end
      property :started do
        key :type, 'string'
        key :format, 'date-time'
        key :description, 'The time that the file began printing'
      end
      property :completed do
        key :type, 'string'
        key :format, 'date-time'
        key :description, 'The time that the file was finished printing'
      end
      property :file do
        key :title, 'file'
        property :name do
          key :type, :string
          key :description, 'The name of the file being printed'
        end
        property :origin do
          key :type, :string
          key :enum, ['sdcard', 'local']
          key :description, 'The origin of the file, local when stored in OctoPrint’s uploads folder, sdcard when stored on the printer’s SD card (if available)'
        end
        property :size do
          key :type, :integer
          key :description, 'The size of the file in bytes. Only available for local files or sdcard files if the printer supports file sizes for sd card files'
        end
        property :date do
          key :type, :integer
          key :description, 'The UNIX timestamp when this file was uploaded. Only available for local files'
        end
      end
      property :estimated_print_time do
        key :type, :integer
        key :description, 'The estimated print time of the file, in seconds'
      end
      property :filament do
        key :title, 'filament'
        property :length do
          key :type, :string
          key :description, 'The length of filament used, in mm'
        end
        property :volume do
          key :type, :string
          key :description, 'The volume of filament used, in cm^3'
        end
      end
      property :progress do
        key :title, 'progress'
        property :completion do
          key :type, :string
          key :description, 'Percentage of completion of the current print job'
        end
        property :file_position do
          key :type, :integer
          key :description, 'Current position in the file being printed, in bytes from the beginning'
        end
        property :print_time do
          key :type, :integer
          key :description, 'Time already spent printing, in seconds'
        end
        property :print_time_left do
          key :type, :integer
          key :description, 'Time already spent printing, in seconds'
        end
      end
    end
  end

  has_one :printer_job
  has_one :printer, through: :printer_job

  mount_base64_uploader :model, ModelUploader
  process_in_background :model, UploadModelJob

  validates_presence_of :model, :model_name, :on => :create

  serialize :data, JSON
end
