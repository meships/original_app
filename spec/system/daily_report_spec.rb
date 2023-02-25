require 'rails_helper'
RSpec.describe '日報機能', type: :system do
 describe '新規作成機能' do
    let!(:user){FactoryBot.create(:user)}
    let!(:admin_user){FactoryBot.create(:admin_user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end

    context '日報を新規作成した場合' do
      it '作成した日報が表示される' do
        login
        visit new_daily_report_path
        fill_in 'daily_report[place]', with: 'task'
        fill_in 'daily_report[date]', with: "002022-12-31"
        fill_in 'daily_report[address]', with: 'task'
        fill_in 'daily_report[action_content]', with: 'task'
        fill_in 'daily_report[tool]', with: 'task'
        click_on '日報登録'
        expect(page).to have_content '日報を作成しました'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:user){FactoryBot.create(:user)}
    let!(:admin_user){FactoryBot.create(:admin_user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end

    context '一覧画面に遷移した場合' do
      it '作成済みの日報一覧が表示される' do
        login
        daily_report = FactoryBot.create(:daily_report, user: user)
        visit daily_reports_path
        expect(page).to have_content '日報一覧'
        sleep(5)
      end
    end
  end

  describe '詳細表示機能' do
        let!(:user){FactoryBot.create(:user)}
        let!(:admin_user){FactoryBot.create(:admin_user)}
        def login
            visit new_session_path
            fill_in 'session_email', with: user.email
            fill_in 'session_password', with: user.password
            click_button "ログイン"
        end
     context '任意の日報詳細画面に遷移した場合' do
       it '該当日報の内容が表示される' do
        login
        daily_report = FactoryBot.create(:daily_report, user: user, place: 'うんち', date: '茨城')
        visit daily_report_path(daily_report)
        expect(page).to have_content '茨城'
       end
     end
  end

  describe '新規作成機能' do
    let!(:user){FactoryBot.create(:user)}
    let!(:admin_user){FactoryBot.create(:admin_user)}
    let!(:label){FactoryBot.create(:label)}
    date = Date.new(2013,12,11)
    def login
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button "ログイン"
    end

    context '地図検索した内容を含む日報を新規作成した場合' do
      it '地図検索した場所に地図が移動している' do
        login
        visit new_daily_report_path
        fill_in 'daily_report[place]', with: 'task'
        fill_in 'daily_report[date]', with: date
        fill_in 'daily_report[address]', with: 'task'
        fill_in 'daily_report[action_content]', with: 'task'
        fill_in 'daily_report[tool]', with: 'task'
        fill_in 'address', with: 'アメリカ'
        click_on '地図検索'
        check "地上"
        sleep(5)
        click_on '日報登録'
        expect(page).to have_content '日報を作成しました'
      end
    end
  end

end