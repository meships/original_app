FactoryBot.define do
  factory :daily_report, class: DailyReport do
    place {'うんち'}
    date {'2022/12/14'}
    address {'茨城'}
    action_content {'調査'}
    tool {'道具'}
    latitude { 36.000000 }
    longitude { 120.000000 }
  end
end
