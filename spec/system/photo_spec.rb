require 'rails_helper'
RSpec.describe '写真機能', type: :system do
  describe '新規作成機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context '写真のタイトルを新規作成した場合' do
        it '作成した写真のタイトルがが表示される' do
            login
            daily_report = FactoryBot.create(:daily_report, user: user, place: 'うんち', date: '茨城')
            visit daily_report_path(daily_report)
            sleep(3)
            click_on "写真を付け加える"
            sleep(3)
            click_on "写真を付け加える"
            sleep(3)
            fill_in 'photo[title]', with: 'タイトルだよ'
            click_on "登録する"
            expect(page).to have_content 'タイトルだよ'
        end
    end
  end

  describe '写真一覧表示機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context '写真一覧画面に遷移した場合' do
      it '作成済みの写真一覧が表示される' do
        login
        daily_report = FactoryBot.create(:daily_report, user: user)
        visit daily_report_path(daily_report)
        click_on "写真を付け加える"
        expect(page).to have_content '写真一覧'
        sleep(5)
      end
    end
  end

  describe '写真詳細表示機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context '任意の写真詳細に遷移した場合' do
      it '該当写真の内容が表示される' do
        login
        daily_report = FactoryBot.create(:daily_report, user: user)
        visit daily_report_path(daily_report)
        click_on "写真を付け加える"
        sleep(3)
        click_on "写真を付け加える"
        sleep(3)
        fill_in 'photo[title]', with: 'タイトルだよ'
        click_on "登録する"
        sleep(3)
        click_on "写真を見る"
        expect(page).to have_content 'タイトル'
        sleep(3)
      end
    end
  end
end