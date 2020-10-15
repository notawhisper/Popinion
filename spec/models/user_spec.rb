require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: '', email: 'test@test.com', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end
    describe 'メールアドレスのテスト' do
      context '空の場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: '', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
      context '@が含まれていない場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'testtest.com', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
      context 'ドメインが記述されていない場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'test@', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
    end
    describe 'パスワードのテスト' do
      context 'passwordが空の場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'test@test.com', password: '', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
      context 'password_confirmationが空の場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'testtest.com', password: 'password', password_confirmation: '')
          expect(user).not_to be_valid
        end
      end
      context 'passwordとpassword_confirmationが一致しない場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'test@test.com', password: 'password', password_confirmation: 'invalid')
          expect(user).not_to be_valid
        end
      end
      context 'passwordが6文字未満の場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: 'test', email: 'test@test.com', password: 'four', password_confirmation: 'four')
          expect(user).not_to be_valid
        end
      end
    end
  end
end
