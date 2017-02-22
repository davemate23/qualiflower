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

ActiveRecord::Schema.define(version: 20170222181717) do

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

  create_table "course_stages", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.string   "assact"
    t.integer  "coursework"
    t.integer  "independent"
    t.string   "ltact"
    t.integer  "placement"
    t.integer  "practical"
    t.integer  "scheduled"
    t.integer  "stage"
    t.integer  "written"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_course_stages_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_course_stages_on_institute_id", using: :btree
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
    t.string   "image"
    t.integer  "location_id"
    t.index ["institute_id"], name: "index_courses_on_institute_id", using: :btree
  end

  create_table "degree_classes", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "degpop"
    t.integer  "degagg"
    t.integer  "degsbj"
    t.integer  "ufirst"
    t.integer  "uupper"
    t.integer  "ulower"
    t.integer  "uother"
    t.integer  "uordinary"
    t.integer  "udistinction"
    t.integer  "umerit"
    t.integer  "upass"
    t.integer  "una"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_degree_classes_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_degree_classes_on_institute_id", using: :btree
  end

  create_table "employments", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "emppop"
    t.integer  "empresp_rate"
    t.integer  "empagg"
    t.integer  "empsbj"
    t.integer  "workstudy"
    t.integer  "study"
    t.integer  "assunemp"
    t.integer  "both"
    t.integer  "noavail"
    t.integer  "work"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_employments_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_employments_on_institute_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "entpop"
    t.integer  "entagg"
    t.integer  "entsbj"
    t.integer  "access"
    t.integer  "alevel"
    t.integer  "bacc"
    t.integer  "degree"
    t.integer  "foundtn"
    t.integer  "noquals"
    t.integer  "other"
    t.integer  "otherhe"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_entries_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_entries_on_institute_id", using: :btree
  end

  create_table "institutes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
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
    t.string   "image"
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
    t.string   "image"
    t.index ["institute_id"], name: "index_locations_on_institute_id", using: :btree
    t.index ["locid"], name: "index_locations_on_locid", using: :btree
    t.index ["ukprn"], name: "index_locations_on_ukprn", using: :btree
  end

  create_table "nhs_nsses", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "nhspop"
    t.integer  "nhsresp_rate"
    t.integer  "nhsagg"
    t.integer  "nhssbj"
    t.integer  "nhsq1"
    t.integer  "nhsq2"
    t.integer  "nhsq3"
    t.integer  "nhsq4"
    t.integer  "nhsq5"
    t.integer  "nhsq6"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_nhs_nsses_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_nhs_nsses_on_institute_id", using: :btree
  end

  create_table "nsses", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "nsspop"
    t.integer  "nssresp_rate"
    t.integer  "nssagg"
    t.integer  "nsssbj"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.integer  "q6"
    t.integer  "q7"
    t.integer  "q8"
    t.integer  "q9"
    t.integer  "q10"
    t.integer  "q11"
    t.integer  "q12"
    t.integer  "q13"
    t.integer  "q14"
    t.integer  "q15"
    t.integer  "q16"
    t.integer  "q17"
    t.integer  "q18"
    t.integer  "q19"
    t.integer  "q20"
    t.integer  "q21"
    t.integer  "q22"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_nsses_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_nsses_on_institute_id", using: :btree
  end

  create_table "qualifications", force: :cascade do |t|
    t.integer  "kisaimcode"
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_qualifications_on_course_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "users_id"
    t.index ["users_id"], name: "index_reviews_on_users_id", using: :btree
  end

  create_table "salaries", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "salpop"
    t.integer  "salresp_rate"
    t.integer  "salagg"
    t.integer  "salsbj"
    t.integer  "ldlq"
    t.integer  "ldmed"
    t.integer  "lduq"
    t.integer  "lq"
    t.integer  "med"
    t.integer  "uq"
    t.integer  "instlq"
    t.integer  "instmed"
    t.integer  "instuq"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_salaries_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_salaries_on_institute_id", using: :btree
  end

  create_table "subject_entities", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "sbj"
    t.string   "subject"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_subject_entities_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_subject_entities_on_institute_id", using: :btree
  end

  create_table "tariffs", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.integer  "tarpop"
    t.integer  "taragg"
    t.integer  "tarsbj"
    t.integer  "t001"
    t.integer  "t048"
    t.integer  "t064"
    t.integer  "t080"
    t.integer  "t096"
    t.integer  "t112"
    t.integer  "t128"
    t.integer  "t144"
    t.integer  "t160"
    t.integer  "t176"
    t.integer  "t192"
    t.integer  "t208"
    t.integer  "t224"
    t.integer  "t240"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_tariffs_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_tariffs_on_institute_id", using: :btree
  end

  create_table "ucas", force: :cascade do |t|
    t.string   "pubukprn"
    t.string   "ukprn"
    t.string   "kiscourseid"
    t.integer  "kismode"
    t.string   "locid"
    t.integer  "ucascourseid"
    t.integer  "course_id"
    t.integer  "institute_id"
    t.integer  "location_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_ucas_on_course_id", using: :btree
    t.index ["institute_id"], name: "index_ucas_on_institute_id", using: :btree
    t.index ["location_id"], name: "index_ucas_on_location_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accreditation_by_courses", "courses"
  add_foreign_key "accreditation_details", "accreditations"
  add_foreign_key "accreditations", "courses"
  add_foreign_key "common_job_types", "courses"
  add_foreign_key "continuations", "courses"
  add_foreign_key "course_stages", "courses"
  add_foreign_key "course_stages", "institutes"
  add_foreign_key "courses", "institutes"
  add_foreign_key "degree_classes", "courses"
  add_foreign_key "degree_classes", "institutes"
  add_foreign_key "employments", "courses"
  add_foreign_key "employments", "institutes"
  add_foreign_key "entries", "courses"
  add_foreign_key "entries", "institutes"
  add_foreign_key "job_types", "courses"
  add_foreign_key "jobs", "courses"
  add_foreign_key "locations", "institutes"
  add_foreign_key "nhs_nsses", "courses"
  add_foreign_key "nhs_nsses", "institutes"
  add_foreign_key "nsses", "courses"
  add_foreign_key "nsses", "institutes"
  add_foreign_key "qualifications", "courses"
  add_foreign_key "reviews", "users", column: "users_id"
  add_foreign_key "salaries", "courses"
  add_foreign_key "salaries", "institutes"
  add_foreign_key "subject_entities", "courses"
  add_foreign_key "subject_entities", "institutes"
  add_foreign_key "tariffs", "courses"
  add_foreign_key "tariffs", "institutes"
  add_foreign_key "ucas", "courses"
  add_foreign_key "ucas", "institutes"
  add_foreign_key "ucas", "locations"
end
