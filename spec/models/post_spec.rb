require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#photo' do
    let(:post) { create(:post) }

    it { expect(post.photo).to be_an_instance_of(ActiveStorage) }
  end
end
