require 'rails_helper'
RSpec.describe User do
  let(:user) { FactoryGirl.create(:user) }


  before { allow(user).to receive(:time_elapsed_in_second).and_return(10)}

  describe '#time_left_in_second' do
    it { expect(user.time_left_in_second).to eq(50) }
  end
end
