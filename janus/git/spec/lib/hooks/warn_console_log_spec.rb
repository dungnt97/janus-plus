require 'spec_helper'
require_relative "../../../lib/hooks/warn_console_log"

RSpec.describe WarnConsoleLog do
  let(:hook) { WarnConsoleLog.new }

  describe "filter" do
    context "there is console.log in the diff" do
      it "return truthy" do
        expect(hook.filter("console.warn")).to be_truthy
      end
    end

    context "there is no console.log in the diff" do
      it "return falsey" do
        expect(hook.filter("console.new")).to be_falsey
      end
    end
  end
end
