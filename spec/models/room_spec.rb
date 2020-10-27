require 'rails_helper'

RSpec.describe Room, type: :model do
  let!(:room_host) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context ':hostが空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: 'ルーム名', description: '議題・詳細', host: nil, group_id: nil, distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context 'ルーム名が空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: '', description: 'ルームの説明', host: room_host, group_id: nil, distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context 'ルーム名が31文字以上の場合' do
      it 'バリデーションにひっかかる' do
        name = "房" * 31
        room = Room.new(name: name, description: 'ルームの説明', host: room_host, group_id: nil, distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context '議題・詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: 'ルーム', description: nil, host: room_host, group_id: nil, distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context '詳細・議題が201文字以上の場合' do
      it 'バリデーションにひっかかる' do
        description = "説" * 201
        room = Room.new(name: "room", description: description, host: room_host, group_id: '', distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context '詳細・議題が空の場合' do
      it 'バリデーションにひっかからない' do
        room = Room.new(name: "room", description: '', host: room_host, group_id: '', distinguish_speaker: true, let_guests_view_all: true, show_member_list: true)
        expect(room).to be_valid
      end
    end
    context 'distinguish_speakerカラムが空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: "room", description: "議題•説明", host: room_host, group_id: '', distinguish_speaker: nil, let_guests_view_all: true, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context 'let_guests_view_allカラムが空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: "room", description: "議題•説明", host: room_host, group_id: '', distinguish_speaker: true, let_guests_view_all: nil, show_member_list: true)
        expect(room).not_to be_valid
      end
    end
    context 'show_member_listカラムが空の場合' do
      it 'バリデーションにひっかかる' do
        room = Room.new(name: "room", description: "議題•説明", host: room_host, group_id: '', distinguish_speaker: true, let_guests_view_all: true, show_member_list: nil)
        expect(room).not_to be_valid
      end
    end
  end
end
