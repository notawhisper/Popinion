FactoryBot.define do
  factory :room do
    name { 1 }
    description { "MyText" }
    group_id { 1 }
    distinguish_speaker { "false" }
    let_guests_view_all { "false" }
    show_member_list { "false" }
  end
end
