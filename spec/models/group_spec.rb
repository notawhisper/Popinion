require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:group_owner) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context 'ownerが空の場合' do
      it 'バリデーションにひっかかる' do
        group = Group.new(name: 'ルーム名', description: '議題・詳細', owner: nil )
        expect(group).not_to be_valid
      end
    end
    context 'nameが空の場合' do
      it 'バリデーションにひっかかる' do
        group = Group.new(name: '', description: '議題・詳細', owner: group_owner )
        expect(group).not_to be_valid
      end
    end
    context 'nameが31文字以上の場合' do
      it 'バリデーションにひっかかる' do
        name = "甲" * 31
        group = Group.new(name: name, description: '議題・詳細', owner: group_owner )
        expect(group).not_to be_valid
      end
    end
    context 'descriptionが301文字以上の場合' do
      it 'バリデーションにひっかかる' do
        description = "説" * 301
        group = Group.new(name: 'name', description: description, owner: group_owner )
        expect(group).not_to be_valid
      end
    end
  end
end
