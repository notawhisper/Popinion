require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:room) { FactoryBot.create(:room, host: user) }
  describe 'バリデーションのテスト' do
    context 'userが空の場合' do
      it 'バリデーションにひっかかる' do
        post = Post.new(content: '内容', user: nil , room: room)
        expect(post).not_to be_valid
      end
    end
    context 'roomが空の場合' do
      it 'バリデーションにひっかかる' do
        post = Post.new(content: '内容', user: user , room: nil)
        expect(post).not_to be_valid
      end
    end
    context 'contentが空の場合' do
      it 'バリデーションにひっかかる' do
        post = Post.new(content: nil, user: user , room: room)
        expect(post).not_to be_valid
      end
    end
    context 'contentが1001文字以上の場合' do
      it 'バリデーションにひっかかる' do
        content = "語" * 1001
        post = Post.new(content: content, user: user , room: room)
        expect(post).not_to be_valid
      end
    end
  end
end
