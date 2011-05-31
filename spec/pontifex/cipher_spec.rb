require 'spec_helper'

module Pontifex
  describe Cipher do
    let(:raw_unencrypted_msg) { "Code in Ruby, live longer!" }
    let(:decrypted_msg) { "CODEI NRUBY LIVEL ONGER" }
    let(:encrypted_msg) {  "GLNCQ MJAFF FVOMB JIYCB" }

    describe "#encrypted" do
      it "should return an encrypted conversion of the input String paramter" do
        msg = Cipher.new(raw_unencrypted_msg)
        msg.encrypted.should == encrypted_msg
      end
    end

    describe "#decrypted" do
      it "should return a decrypted plain text conversion of the input String parameter" do
        msg = Cipher.new(encrypted_msg)
        msg.decrypted.should == decrypted_msg
      end
    end
  end
end
