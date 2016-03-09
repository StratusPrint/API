class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'StratusPrint API'
      key :description, '3D printer management and environmental monitoring'
      contact do
      end
      license do
        key :name, 'Apache'
      end
    end
    key :schemes, ['https']
    if Rails.env.development?
      key :host, 'dev.api.stratusprint.com'
    else
      key :host, 'api.stratusprint.com'
    end
    key :basePath, '/v1'
    key :consumes, ['application/json']
    key :produces, ['application/json']

    response 500 do
      key :description, 'User successfully registered'
    end

    security_definition :bearer do
      key :type, :apiKey
      key :name, :Authorization
      key :in, :header
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Api::V1::HubsController,
    Api::V1::SensorsController,
    Api::V1::PrintersController,
    Api::V1::DataPointsController,
    Api::V1::JobsController,
    Api::V1::UsersController,
    User,
    Hub,
    Sensor,
    Printer,
    Job,
    DataPoint,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
