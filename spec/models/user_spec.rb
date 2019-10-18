require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe '#password' do
    it { should validate_presence_of(:password_digest) }
  end
end
