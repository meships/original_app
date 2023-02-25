require 'rails_helper'

RSpec.describe "ユーザーモデル機能", type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザーの名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(name: '', email: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーのアドレスが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: '失敗テスト2', email: '' )
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーのパスワードが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'user1', email: 'user1@seed.com', password: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーの名前とアドレスとパスワードの内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'user1', email: 'user1@seed.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end
end

RSpec.describe "日報モデル機能", type: :model do
  describe 'バリデーションのテスト' do
    context '日報の現場名が空の場合' do
      it 'バリデーションにひっかる' do
        daily_report = DailyReport.new(place: '')
        expect(daily_report).not_to be_valid
      end
    end
    context '日報の住所が空の場合' do
      it 'バリデーションにひっかかる' do
        daily_report = DailyReport.new(place: '失敗テスト2', address: '' )
        expect(daily_report).not_to be_valid
      end
    end
    context '日報の作業内容が空の場合' do
      it 'バリデーションにひっかかる' do
        daily_report = DailyReport.new(place: '失敗テスト3', address: '失敗テスト3', action_content: '' )
        expect(daily_report).not_to be_valid
      end
    end
    context '日報の現場名と住所と作業内容に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.create(name: 'user1', email: 'user1@seed.com', password: 'password')
        daily_report = DailyReport.create(place: '成功テスト4', date: Date.today, address: '成功テスト4', action_content: '成功テスト4', user_id: user.id)
        expect(daily_report).to be_valid
      end
    end
  end
end
