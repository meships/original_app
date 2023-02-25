require 'rails_helper'
RSpec.describe 'ラベル追加機能', type: :system do

  describe '新規作成機能' do
    let!(:user){FactoryBot.create(:user)}
    let!(:admin_user){FactoryBot.create(:admin_user)}
    let!(:label){FactoryBot.create(:label)}
    def login
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button "ログイン"
    end

    context 'ラベルを含む日報を新規作成した場合' do
      it '設定したラベルが詳細画面に存在する' do
        login
        visit new_daily_report_path
        fill_in 'daily_report[place]', with: 'task'
        #fill_in 'daili_report[date]', with: "002022-12-31"
        fill_in 'daily_report[address]', with: 'task'
        fill_in 'daily_report[action_content]', with: 'task'
        fill_in 'daily_report[tool]', with: 'task'
        check "地上"
        sleep(5)
        click_on '日報登録'
        expect(page).to have_content '日報を作成しました'
      end
    end
  end
end



