require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#photo' do
    let(:post) { create(:post) }

    it {nexpect(post.photo).to be_an_instance_of(ActiveStorage::Attached::One) }
  end
end
