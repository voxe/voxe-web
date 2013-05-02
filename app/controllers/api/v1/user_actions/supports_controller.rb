class Api::V1::UserActions::SupportsController < Api::V1::UserActions::UserActionsController
  skip_load_and_authorize_resource
end
