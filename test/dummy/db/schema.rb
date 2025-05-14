
ActiveRecord::Schema[7.0].define(version: 2023_04_25_154701) do
  create_table "users", force: :cascade do |t|
    t.string "email"
  end
  create_table "comments", force: :cascade do |t|
    t.bigint  :commentable_id
    t.string  :commentable_type
  end
end
