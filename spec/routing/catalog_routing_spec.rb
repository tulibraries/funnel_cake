# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Routing" do
  describe "Paths Generated by Custom Routes:" do
    # paths generated by custom routes
    it "has a path for xml" do
      expect(get: "/catalog/foo.xml").to route_to(controller: "catalog", action: "show", id: "foo", format: "xml")
    end

    it "has a path for json" do
      expect(get: "/catalog/foo.json").to route_to(controller: "catalog", action: "show", id: "foo", format: "json")
    end

    it "can still handle id with periods" do
      expect(get: "/catalog/foo.bar.xml").to route_to(controller: "catalog", action: "show", id: "foo.bar", format: "xml")
    end
  end
end
