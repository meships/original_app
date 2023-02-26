require 'rails_helper'
RSpec.describe 'Ajaxコメント機能', type: :system do
  describe 'コメント新規作成機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context 'コメントを新規作成場合' do
      it '作成したコメントが表示される' do
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
        fill_in 'photo_comment[comment]', with: "写真のコメント"
        click_on "登録する"
        expect(page).to have_content '写真のコメント'
        sleep(3)
      end
    end
  end

  describe 'コメント編集機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context 'コメント編集を押した場合' do
      it 'コメント編集画面が表示される' do
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
        fill_in 'photo_comment[comment]', with: "写真のコメント"
        click_on "登録する"
        sleep(3)
        click_on "コメント編集"
        sleep(3)
        click_on "更新する"
        expect(page).to have_content '写真のコメント'
        sleep(3)
      end
    end
  end

  describe 'コメント編集機能' do
    let!(:user){FactoryBot.create(:user)}
    def login
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
    end
    context 'コメント編集を押した場合' do
      it 'コメント編集画面が表示される' do
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
        fill_in 'photo_comment[comment]', with: "写真のコメント"
        click_on "登録する"
        sleep(3)
        click_on "コメント削除"
        sleep(3)
        page.accept_confirm
        expect(page).to have_content '写真のコメント'
        sleep(3)
      end
    end
  end
end