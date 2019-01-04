require 'spec_helper'
require_relative "../../../lib/hooks"

RSpec.describe Git::Debugger do
  let(:hook) { Git::Debugger.new }

  describe "filter" do
    context "there is byebug in the diff" do
      it "return falsey" do
        ok, message = hook.filter(["byebug"])
        expect(ok).to be_falsey
        expect(message).to eq "[byebug] found in [byebug]"
      end
    end

    context "there is no byebug in the diff" do
      it "return truthy" do
        ok, message = hook.filter(["debugging"])
        expect(ok).to be_truthy
      end
    end
  end
end
