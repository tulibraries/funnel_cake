# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Active Storage direct uploads", type: :request do
  it "does not expose the direct upload endpoint" do
    post "/rails/active_storage/direct_uploads",
      params: { blob: { filename: "test.png", byte_size: 1024,
                        checksum: "1B2M2Y8AsgTpgAmY7PhCfg==", content_type: "image/png" } },
      as: :json

    expect(response).to have_http_status(:not_found)
  end
end
