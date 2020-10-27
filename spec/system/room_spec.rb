require 'rails_helper'

RSpec.describe 'チャットルームにおける機能', type: :system do
  let!(:room_host) { FactoryBot.create(:user) }
  let!(:login_user) { FactoryBot.create(:user) }
  let!(:guest_user) { FactoryBot.create(:user) }
  let!(:room_not_to_group) { FactoryBot.create(:room, group_id: nil, host: room_host) }
  describe 'チャット投稿機能' do
    before do
      visit new_user_session_path
      fill_in :user_email, with: login_user.email
      fill_in :user_password, with: login_user.password
      click_on I18n.t('users.sessions.new.sign_in')
    end
    context 'ログインしている場合' do
      it 'チャットルームからチャットを投稿できる' do
        visit room_path(room_not_to_group)
        pre_post_count = Post.all.size
        click_on I18n.t('helpers.submit.submit')
        fill_in 'post_content', with: 'こんにちは'
        click_on 'post_in_modal'
        expected_count = pre_post_count + 1
        expect(Post.all.size).to eq expected_count
        expect(page).to have_content Post.last.content
      end
    end
  end

  describe 'チャットルーム作成機能' do
    before do
      visit new_user_session_path
      fill_in :user_email, with: login_user.email
      fill_in :user_password, with: login_user.password
      click_on I18n.t('users.sessions.new.sign_in')
    end
    context 'チャットルーム作成ボタンを押した場合' do
      before do
        click_on I18n.t('layouts.application.create_room')
        fill_in 'room_name', with: '新規作成テスト'
        fill_in 'room_description', with: '新しく作りました'
        click_on I18n.t('helpers.submit.create')
      end
      it 'チャットルームが保存される' do
        expect(Room.last.name).to eq "新規作成テスト"
      end
      it '作成者がそのルームのホストになる' do
        expect(Room.last.host).to eq login_user
      end
    end
    context 'グループページから「グループメンバーでルームを作成」を押した場合' do
      #system/group_spec.rbで実施
    end
  end
  # describe 'PDF機能' do
  #   #   let!(:post) { FactoryBot.create(:post,
  #   #                                   content: "PDFテスト",
  #   #                                   room: room_not_to_group,
  #   #                                   user: room_host
  #   #   ) }
  #   #   before do
  #   #     visit new_user_session_path
  #   #     fill_in :user_email, with: room_host.email
  #   #     fill_in :user_password, with: room_host.password
  #   #     click_on I18n.t('users.sessions.new.sign_in')
  #   #   end
  #   #   context 'チャットルームにいる場合' do
  #   #     before do
  #   #       visit room_path(room_not_to_group)
  #   #     end
  #   #     # it 'ルーム内の投稿をPDFにできる' do
  #   #     #   # これで本当に担保できているかは不明
  #   #     #   click_on I18n.t('rooms.show.download')
  #   #     #   sleep 7
  #   #     #   expect(page.title).to eq ""
  #   #     # end
  #   #   end
  #   # end
  describe 'チャットルーム設定機能' do
    context 'Roomモデルのdistinguish_speakerカラムがtrueで、ログインユーザーがホストのとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: room_host.email
        fill_in :user_password, with: room_host.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      let!(:room_distinguish_true) { FactoryBot.create(:room, group_id: nil,
                                                       host: room_host,
                                                       chat_members: [room_host, login_user],
                                                       distinguish_speaker: true
      ) }
      it 'ポスト一覧にcodenumberが表示される' do
        FactoryBot.create(:post, user: room_host, room: room_distinguish_true)
        visit room_path(room_distinguish_true)
        click_on I18n.t('rooms.show.assign_code_number')
        expect(page).to have_content 'Code:'
      end
    end
    context 'Roomモデルのlet_guests_view_allカラムがtrueで、ログインユーザーがホストでないとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      let!(:room_guests_view_all) { FactoryBot.create(:room,
                                                      group_id: nil,
                                                      host: room_host,
                                                      chat_members: [room_host,
                                                                     login_user,
                                                                     guest_user],
                                                      let_guests_view_all: true
      ) }
      it 'ポスト一覧にログインユーザーとホスト以外の投稿も表示される' do
        others_post = FactoryBot.create(:post, user: guest_user, room: room_guests_view_all)
        visit room_path(room_guests_view_all)
        expect(page).to have_content others_post.content
      end
      it 'ルーム内の投稿をPDFにできる' do
        # これで本当に担保できているかは不明
        visit room_path(room_guests_view_all)
        click_on I18n.t('rooms.show.download')
        sleep 7
        expect(page.title).to eq ""
      end
    end
    context 'Roomモデルのlet_guests_view_allカラムがfalseで、ログインユーザーがホストでないとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      let!(:room_guests_view_not_all) { FactoryBot.create(:room,
                                                      group_id: nil,
                                                      host: room_host,
                                                      chat_members: [room_host,
                                                                     login_user,
                                                                     guest_user],
                                                      let_guests_view_all: "false"
      ) }
      it 'ポスト一覧にログインユーザーとホスト以外の投稿は表示されない' do
        others_post = FactoryBot.create(:post, user: guest_user, room: room_guests_view_not_all)
        visit room_path(room_guests_view_not_all)
        expect(page).not_to have_content others_post.content
      end
      it 'PDF作成ボタンが表示されない' do
        visit room_path(room_guests_view_not_all)
        expect(page).not_to have_button I18n.t('rooms.show.download')
      end
    end
    context 'Roomモデルのshow_member_listカラムがtrueで、ログインユーザーがホストでないとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      let!(:room_show_members) { FactoryBot.create(:room,
                                                      group_id: nil,
                                                      host: room_host,
                                                      chat_members: [room_host,
                                                                     login_user,
                                                                     guest_user],
                                                      show_member_list: true
      ) }
      it 'メンバー一覧にメンバーのユーザーネームが表示される' do
        visit room_path(room_show_members)
        click_on I18n.t('chat_members.index.title')
        expect(page).to have_content room_host.name
        expect(page).to have_content guest_user.name
      end
    end
    context 'Roomモデルのshow_member_listカラムがfalseで、ログインユーザーがホストでないとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: login_user.email
        fill_in :user_password, with: login_user.password
        click_on I18n.t('users.sessions.new.sign_in')
      end
      let!(:room_not_show_members) { FactoryBot.create(:room,
                                                   group_id: nil,
                                                   host: room_host,
                                                   chat_members: [room_host,
                                                                  login_user,
                                                                  guest_user],
                                                   show_member_list: "false"
      ) }
      it 'メンバー一覧にメンバーのユーザーネームが表示されない' do
        visit room_path(room_not_show_members)
        click_on I18n.t('chat_members.index.title')
        expect(page).not_to have_content room_host.name
        expect(page).not_to have_content guest_user.name
        expect(page).to have_content I18n.t('chat_members.index.memberlist_not_available')
      end
    end
  end
end
