require 'rails_helper'

RSpec.describe 'グループ機能', type: :system do
  let!(:login_user) { FactoryBot.create(:user) }
  let!(:not_owner) { FactoryBot.create(:user) }
  let!(:existing_group) { FactoryBot.create(:group,
                                            owner: login_user,
                                            group_members: [login_user, not_owner]
  ) }
  let!(:room_to_existing_group) { FactoryBot.create(:room,
                                                    group: existing_group,
                                                    host: login_user,
                                                    chat_members: [login_user]
  ) }
  describe 'グループ作成機能' do
    before do
      visit new_user_session_path
      fill_in :user_email, with: login_user.email
      fill_in :user_password, with: login_user.password
      click_on I18n.t('users.sessions.new.sign_in')
    end
    context 'グループを作成した場合' do
      before do
        click_on I18n.t('layouts.application.create_group')
        fill_in :group_name, with: '新規作成'
        fill_in :group_description, with: 'グループを新規作成しました'
        click_on I18n.t('groups.submit.create')
      end
      it 'グループが保存される' do
        expect(Group.last.description).to eq 'グループを新規作成しました'
      end
      it '作成したユーザーがオーナーになる' do
        expect(Group.last.owner).to eq login_user
      end
    end
  end
  describe 'グループ編集機能' do
    context 'グループのオーナーである場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it 'グループ情報を編集できる' do
        visit group_path(existing_group)
        click_on I18n.t('groups.show.edit')
        fill_in :group_name, with: '更新します'
        fill_in :group_description, with: 'グループ情報を更新しました'
        click_on I18n.t('helpers.submit.update')
        expect(Group.first.description).to eq 'グループ情報を更新しました'
      end
    end
    context 'グループのオーナーではない場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: not_owner.email
        fill_in :user_password, with: not_owner.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it '「グループ設定を編集」ボタンが現れない' do
        expect(page).not_to have_button I18n.t('groups.show.edit')
      end
    end
  end
  describe 'グループ削除機能' do
    context 'グループのオーナーである場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it 'グループを削除できる' do
        visit group_path(existing_group)
        page.accept_confirm do
          click_on I18n.t('groups.show.delete')
        end
        sleep 1
        expect(Group.where(owner: login_user).count).to eq 0
      end
    end
    context 'グループのオーナーではない場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: not_owner.email
        fill_in :user_password, with: not_owner.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      it '「このグループを削除」ボタンが現れない' do
        expect(page).not_to have_button I18n.t('groups.show.delete')
      end
    end
  end
  describe 'グループ詳細ページにおける機能' do
    context 'グループ詳細ページにいる場合' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
        visit group_path(existing_group)
      end
      it 'グループと紐づいているチャットルームの情報が表示される' do
        expect(page).to have_content room_to_existing_group.name
      end
      it 'グループメンバー全員が所属するチャットルームを作成できる' do
        click_on 'default_create_room_to_group_button'
        fill_in :room_name, with: "グループ用チャット"
        fill_in :room_description, with: "グループメンバー全員が所属します"
        click_on I18n.t('helpers.submit.create')
        expect(Room.last.chat_members).to eq existing_group.group_members
      end
    end
  end
end
