require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      before do
        visit  new_user_registration_path
        fill_in :user_name, with: 'user'
        fill_in :user_email, with: 'user@user.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "Sign up"
      end
      it 'ユーザー詳細ページに飛んでいる' do
        expect(page).to have_content "マイページ"
      end
      it 'ログイン状態になっている' do
      end
    end
  end
  # describe 'ログイン機能' do
  #   context 'ログインした場合' do
  #     it 'ログインすることができる' do
  #     end
  #     it 'ユーザー詳細ページにアクセスできる' do
  #     end
  #     it 'ログアウトができる' do
  #     end
  #   end
  # end
end
