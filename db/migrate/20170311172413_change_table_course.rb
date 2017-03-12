class ChangeTableCourse < ActiveRecord::Migration[5.0]

  def change
  change_table(:courses)  do |t|
    t.remove :engfee, :pubukprn, :ukprn,:assurl, :crseurl, :distance, :employurl, :feetbc, :honours, :foundation,
     :jacs1, :jacs2, :jacs3, :kiscourseid, :kismode,:kistype, :ldcs1, :ldcs2, :ldcs3, :level, :locchnge, :lturl, :meanssup,
     :nhs, :nifee, :noncreditassess, :numstage, :othsup, :relatedkis1, :relatedkis2, :relatedkis3, :sandwich, :scotfee, :supporturl,
     :ucasprogid,:ukprnapply, :varfee,:wafee, :waiver, :welsh, :yearabroad, :kisaim, :avgwritten, :avgcoursework, :avgscheduled

    t.text :description
    t.string :duration
    t.string :mode_of_study
    t.string :string
    t.text :contact_details
    t.text :entry_requirements
    t.text :future_careers

  end
end

end
