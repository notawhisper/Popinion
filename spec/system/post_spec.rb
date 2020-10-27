require 'rails_helper'

RSpec.describe 'チャット投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe 'チャット投稿機能' do
    context 'ログインしている場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: user.email
        fill_in :user_password, with: user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it 'チャットを投稿できる' do

      end
    end
  end
end
