require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#photo' do
    let(:post) { build(:post) }

    it { expect(post.photo).to be_an_instance_of(ActiveStorage::Attached::One) }
  end
end
