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

    context 'nameが30文字以内の場合' do
      it '有効であること' do
        user = FactoryBot.build(:user, name: 'a' * 30)
        expect(user).to be_valid
      end
    end
  
    context 'nameが31文字以上の場合' do
      it '無効であること' do
        user = FactoryBot.build(:user, name: 'a' * 31)
        expect(user).not_to be_valid
      end
    end

    context 'バリデーションのテスト' do
      it 'emailが255文字以内の場合は有効であること' do
        user = User.new(
          name: 'test',
          email: 'a' * 243 + '@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to be_valid
      end
    end

    context 'バリデーションのテスト' do
      it 'emailが256文字以上の場合は無効であること' do
        user = User.new(
          name: 'test',
          email: 'a' * 244 + '@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).not_to be_valid
      end
    end

    context 'passwordが6文字以上の場合' do
      it '有効であること' do
        user = User.new(
          name: 'test',
          email: 'a' * 243 + '@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to be_valid
      end
    end

    context 'passwordが5文字以下の場合' do
      it '無効であること' do
        user = User.new(
          name: 'test',
          email: 'a' * 243 + '@example.com',
          password: 'passw',
          password_confirmation: 'passw'
        )
        expect(user).not_to be_valid
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

    context 'placeが30文字以内の場合' do
      it 'バリデーションが通る' do
        user = User.create(name: 'user1', email: 'user1@seed.com', password: 'password')
        daily_report = DailyReport.create(place: 'a' * 30, date: Date.today, address: '成功テスト4', action_content: '成功テスト4', tool: '成功テスト4', user_id: user.id)
        expect(daily_report).to be_valid
      end
    end

    context 'placeが31文字以内の場合' do
      it 'バリデーションに引っかかる' do
        user = User.create(name: 'user1', email: 'user1@seed.com', password: 'password')
        daily_report = DailyReport.create(place: 'a' * 31, date: Date.today, address: '成功テスト4', action_content: '成功テスト4', tool: '成功テスト4', user_id: user.id)
        expect(daily_report).not_to be_valid
      end
    end

  end
end


RSpec.describe "Ajaxコメント機能", type: :model do
  describe 'バリデーションのテスト' do
    context 'コメント欄が空の場合' do
      it 'バリデーションにひっかる' do
        photo_comment = PhotoComment.new(comment: '')
        expect(photo_comment).not_to be_valid
      end
    end
    context 'コメント欄が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.create(name: 'user1', email: 'user1@seed.com', password: 'password')
        daily_report = DailyReport.create(place: '成功テスト4', date: Date.today, address: '成功テスト4', action_content: '成功テスト4', user_id: user.id)
        photo = Photo.create(daily_report_id: daily_report.id, title: 'バイバイ')
        photo_comment = PhotoComment.new(photo_id: photo.id, comment: "どうですか")
        expect(photo_comment).to be_valid
      end
    end
  end
end

RSpec.describe "写真タイトル", type: :model do
  describe 'バリデーションのテスト' do
    context 'タイトルが空の場合' do
      it 'バリデーションにひっかる' do
        photo = Photo.new(title: '')
        expect(photo).not_to be_valid
      end
    end
    context 'タイトルが記載されている場合' do
      it 'バリデーションが通る' do
        user = User.create(name: 'user1', email: 'user1@seed.com', password: 'password')
        daily_report = DailyReport.create(place: '成功テスト4', date: Date.today, address: '成功テスト4', action_content: '成功テスト4', user_id: user.id)
        photo = Photo.new(daily_report_id: daily_report.id,title: 'バイバイ')
        expect(photo).to be_valid
      end
    end
  end
end