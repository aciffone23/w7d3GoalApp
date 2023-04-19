require 'rails_helper'

RSpec.describe User, type: :model do
    # FIGVAPEBR
  subject {User.create!(username: 'lilly_llama', password:'password')}

  it {should validate_presence_of(:username)}
#   it {should validate_presence_of(:session_token)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_uniqueness_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}

  it {should have_many(:goals)}

  describe 'is_password?' do
    let(:user) { create(:user) }

    context 'with a valid password' do
        it 'should return true' do
            expect(user.is_password?('password')).to be true
        end
    end
    context 'with an invalid password' do
        it 'should return false' do
            expect(user.is_password?('passwd')).to be false
        end
    end
  end

  describe 'password security' do
    it 'does not save password to database' do
        FactoryBot.create(:user)
        user = User.find_by(id: User.last.id)
        expect(user.password).not_to eq('password')
    end

    it 'secures password using BCrypt' do
        expect(BCrypt::Password).to receive(:create).with("abcdef")
        FactoryBot.build(:user, password: "abcdef")
    end
  end

  describe 'properly creating and resetting session token' do

    let(:user) { User.create(username: 'lilly_llama', password:'password') }

    it 'generates session token when nil' do
        FactoryBot.create(:user)
        user2 = User.find_by(id: User.last.id)
        expect(user2.session_token).not_to be nil
    end

    it 'properly resets session token' do
        old_session_token = user.session_token
        new_session_token = user.reset_session_token!
        expect(old_session_token).not_to eq(new_session_token)
        expect(new_session_token).to eq(user.session_token)
    end
  end



end
