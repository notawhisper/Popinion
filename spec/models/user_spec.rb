require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    describe '新規作成時' do
      context '名前が空の場合' do
        it 'バリデーションにひっかかる' do
          user = User.new(name: '', email: 'test@test.com', password: 'password', password_confirmation: 'password')
          expect(user).not_to be_valid
        end
      end
      context '名前が31文字以上の場合' do
        it 'バリデーションにひっかかる' do
          name = "甲" * 31
          user = User.new(name: name, email: 'test@test.com', password: 'password', password_confirmation: 'password')
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
        context 'すでに登録されているアドレスの場合' do
          let!(:existing_user) { FactoryBot.create(:user) }
          it 'バリデーションにひっかかる' do
            user = User.new(name: 'test', email: existing_user.email, password: 'password', password_confirmation: 'password')
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

    # 急ぎでない内容だと思われるので後回し
    # describe '更新時' do
    #   describe 'User編集時のテスト' do
    #     let!(:user) { FactoryBot.create(:user) }
    #     context '現在のパスワードが空の場合' do
    #       it 'バリデーションに引っかかる' do
    #         new_name = "new_name"
    #         new_email = "new_email"
    #         new_password = "password2"
    #         user.update(name: new_name, email: new_email, password: new_password, password_confirmation: new_password)
    #         expect(user).not_to be_valid
    #       end
    #     end
    #   end
    # end
  end
end
