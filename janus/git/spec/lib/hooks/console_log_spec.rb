require 'spec_helper'
require_relative "../../../lib/hooks"

RSpec.describe Git::ConsoleLog do
  let(:hook) { Git::ConsoleLog.new }

  describe "filter" do
    context "there is console.log in the diff" do
      it "return falsey" do
        ok, message = hook.filter("console.warn")
        expect(ok).to be_falsey
        expect(message).to eq "console.warn found in diff"
      end
    end

    context "there is no console.log in the diff" do
      it "return truthy" do
        ok, message = hook.filter("console.new")
        expect(ok).to be_truthy
      end
    end
  end
end
