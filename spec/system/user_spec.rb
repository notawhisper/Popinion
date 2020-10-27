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
        visit new_user_session_path
        fill_in :user_email, with: user.email
        fill_in :user_password, with: user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it 'ユーザー詳細ページに遷移する' do
        expect(page).to have_content I18n.t('users.show.title')
      end
      it 'ログアウトできる' do
        click_on I18n.t('layouts.application.sign_out')
        expect(page).to have_content I18n.t('top.index.sign_in')
      end
    end
  end
  describe 'プロフィール編集機能' do
    before do
      visit new_user_session_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password
      click_on I18n.t('users.sessions.new.sign_in')
      visit edit_user_registration_path(user)
    end
    context '現在のパスワードが適正でない場合' do
      it '更新が失敗する' do
        new_name = "new_name"
        new_email = "new_email@test.com"
        new_password = "password2"
        fill_in 'user_name', with: new_name
        fill_in 'user_email', with: new_email
        fill_in 'user_password', with: new_password
        fill_in 'user_password_confirmation', with: new_password
        fill_in 'user_current_password', with: nil
        click_on I18n.t('users.registrations.edit.update')
        expect(user.name).to eq user.name
        expect(user.name).not_to eq new_name
      end
    end
    context '現在のパスワードが適正である場合' do
      it '更新が成功する' do
        new_name = "new_name"
        new_email = "new_email@test.com"
        new_password = "password2"
        fill_in 'user_name', with: new_name
        fill_in 'user_email', with: new_email
        fill_in 'user_password', with: new_password
        fill_in 'user_password_confirmation', with: new_password
        fill_in 'user_current_password', with: user.password
        click_on I18n.t('users.registrations.edit.update')
        expect(page).to have_content new_name
      end
    end
    describe 'ユーザーの削除機能' do
      context 'ユーザー削除のボタンをおした場合' do
        before do
          page.accept_confirm do
            click_on I18n.t('users.registrations.edit.cancel_my_account')
          end
        end
        it 'ユーザーが削除される' do
          sleep 1
          expect(User.where(id: user.id).count).to eq 0
        end
      end
    end
  end
end
