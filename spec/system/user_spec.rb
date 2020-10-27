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
        click_on I18n.t('users.registrations.new.sign_up')
      end
      it 'ユーザー詳細ページに遷移する' do
        expect(page).to have_content I18n.t('users.show.title')
      end
    end
  end
  describe 'ログイン・ログアウト機能' do
    context 'ログインした場合' do
      before do
        visit  new_session_path
        fill_in :user_email, with: user.email
        fill_in :user_password, with: user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it 'ユーザー詳細ページに遷移する' do
        expect(page).to have_content I18n.t('users.show.title')
      end
    end
  end
end
