# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130517081936) do

  create_table "pages", :force => true do |t|
    t.integer  "person_id"
    t.text     "text"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages_words", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "word_id"
  end

  create_table "paper_uses", :force => true do |t|
    t.integer  "paper_id"
    t.integer  "phrase_id"
    t.integer  "frequency"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "papers", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  create_table "passages", :force => true do |t|
    t.text     "text"
    t.integer  "speaker_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  add_index "passages", ["speaker_id"], :name => "index_passages_on_speaker_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "branch",     :limit => nil
    t.string   "party",      :limit => nil
    t.float    "score1"
    t.float    "score2"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "year"
  end

  add_index "people", ["branch"], :name => "index_people_on_branch"
  add_index "people", ["name", "year", "branch"], :name => "index_people_on_name_and_year_and_branch"
  add_index "people", ["year"], :name => "index_people_on_year"

  create_table "phrases", :force => true do |t|
    t.string   "stem"
    t.float    "chi2"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.float    "chi2b"
    t.integer  "uses_count", :default => 0
  end

  add_index "phrases", ["chi2"], :name => "index_phrases_on_chi2"
  add_index "phrases", ["chi2b"], :name => "index_phrases_on_chi2b"

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "party"
    t.integer  "year"
    t.float    "score"
    t.string   "branch"
    t.float    "score2"
  end

  add_index "speakers", ["name", "year", "branch"], :name => "index_speakers_on_name_and_year_and_branch"
  add_index "speakers", ["party"], :name => "index_speakers_on_party"
  add_index "speakers", ["year"], :name => "index_speakers_on_year"

  create_table "uses", :force => true do |t|
    t.string   "text"
    t.integer  "passage_id"
    t.integer  "phrase_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uses", ["passage_id"], :name => "index_uses_on_passage_id"
  add_index "uses", ["phrase_id"], :name => "index_uses_on_phrase_id"

  create_table "words", :force => true do |t|
    t.string   "stem"
    t.string   "text"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "branch",     :limit => nil
    t.integer  "year"
  end

  add_index "words", ["stem", "year", "branch"], :name => "index_words_on_stem_and_year_and_branch"

end
