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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170209214643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accreditation_by_courses", force: :cascade do |t|
    t.string   "accbodyname"
    t.text     "acctype"
    t.string   "hep"
    t.string   "kiscoursetitle"
    t.string   "kiscourseid"
    t.integer  "course_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["course_id"], name: "index_accreditation_by_courses_on_course_id", using: :btree
  end

  create_table "accreditation_details", force: :cascade do |t|
    t.string   "accurl"
    t.text     "acctext"
    t.string   "acctype"
    t.integer  "accreditation_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["accreditation_id"], name: "index_accreditation_details_on_accreditation_id", using: :btree
    t.index ["acctype"], name: "index_accreditation_details_on_acctype", using: :btree
  end

  create_table "accreditations", force: :cascade do |t|
    t.string   "ukprn"
    t.string   "pubukprn"
    t.string   "kiscourse"
    t.string   "accurl"
    t.text     "acctext"
    t.string   "acctype"
    t.integer  "kismode"
    t.integer  "accdepend"
    t.string   "accdependurl"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["acctype"], name: "index_accreditations_on_acctype", using: :btree
    t.index ["course_id"], name: "index_accreditations_on_course_id", using: :btree
    t.index ["kiscourse"], name: "index_accreditations_on_kiscourse", using: :btree
  end

  create_table "common_job_types", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscoursid"
    t.integer  "kismode"
    t.integer  "compop"
    t.integer  "comresp_rate"
    t.integer  "comagg"
    t.string   "comsbj"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_common_job_types_on_course_id", using: :btree
  end

  create_table "continuations", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "contpop"
    t.integer  "contagg"
    t.string   "contsbj"
    t.integer  "ucont"
    t.integer  "udormant"
    t.integer  "ugained"
    t.integer  "uleft"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ulower"
    t.index ["course_id"], name: "index_continuations_on_course_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "engfee"
    t.string   "url"
    t.integer  "institute_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "assurl"
    t.string   "crseurl"
    t.boolean  "distance"
    t.string   "employurl"
    t.boolean  "feetbc"
    t.boolean  "honours"
    t.integer  "foundation"
    t.string   "jacs1"
    t.string   "jacs2"
    t.string   "jacs3"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "kistype"
    t.string   "ldcs1"
    t.string   "ldcs2"
    t.string   "ldcs3"
    t.string   "level"
    t.boolean  "locchnge"
    t.string   "lturl"
    t.boolean  "meanssup"
    t.boolean  "nhs"
    t.integer  "nifee"
    t.boolean  "noncreditassess"
    t.integer  "numstage"
    t.boolean  "othsup"
    t.string   "relatedkis1"
    t.string   "relatedkis2"
    t.string   "relatedkis3"
    t.integer  "sandwich"
    t.integer  "scotfee"
    t.string   "supporturl"
    t.string   "ucasprogid"
    t.string   "ukprnapply"
    t.integer  "varfee"
    t.integer  "wafee"
    t.boolean  "waiver"
    t.integer  "welsh"
    t.integer  "yearabroad"
    t.integer  "kisaim"
    t.integer  "avgwritten"
    t.integer  "avgcoursework"
    t.integer  "avgscheduled"
    t.index ["institute_id"], name: "index_courses_on_institute_id", using: :btree
  end

  create_table "institutes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "picture"
    t.string   "suurl"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "ukprn"
    t.string   "pubukprn"
    t.string   "country"
    t.string   "pubukprncountry"
    t.boolean  "tefmark"
    t.integer  "q24"
    t.integer  "q24pop"
    t.integer  "q24resp_rate"
  end

  create_table "job_types", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "jobpop"
    t.integer  "jobresp_rate"
    t.integer  "jobagg"
    t.string   "jobsbj"
    t.integer  "profman"
    t.integer  "otherjob"
    t.integer  "unkwn"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_job_types_on_course_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.text     "title"
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.string   "comsbj"
    t.integer  "perc"
    t.integer  "order"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["course_id"], name: "index_jobs_on_course_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "ukprn"
    t.text     "name"
    t.decimal  "lat"
    t.decimal  "long"
    t.string   "locid"
    t.string   "locukprn"
    t.string   "loccountry"
    t.integer  "privatelower"
    t.integer  "privateupper"
    t.string   "suurl"
    t.string   "accomurl"
    t.integer  "instbeds"
    t.integer  "instlower"
    t.integer  "instupper"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["institute_id"], name: "index_locations_on_institute_id", using: :btree
    t.index ["locid"], name: "index_locations_on_locid", using: :btree
    t.index ["ukprn"], name: "index_locations_on_ukprn", using: :btree
  end

  add_foreign_key "accreditation_by_courses", "courses"
  add_foreign_key "accreditation_details", "accreditations"
  add_foreign_key "accreditations", "courses"
  add_foreign_key "common_job_types", "courses"
  add_foreign_key "continuations", "courses"
  add_foreign_key "courses", "institutes"
  add_foreign_key "job_types", "courses"
  add_foreign_key "jobs", "courses"
  add_foreign_key "locations", "institutes"
end
