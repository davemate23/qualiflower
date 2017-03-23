class SyncWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(sync_table)
    if sync_table == "Institute"

      Institute.import_csv_api

    elsif sync_table == "Location"


    elsif sync_table == "Job"

         Job.scrap_jobs

    elsif sync_table == "JobCategory"

      JobCategory.scrap_job_categories

    elsif sync_table == "Course"

      # Institute.import_csv_api

    elsif sync_table == "CourseStats"

      CourseStat.get_course_stats

    end

    # snippet = Snippet.find(snippet_id)
    # uri = URI.parse("http://pygments.appspot.com/")
    # request = Net::HTTP.post_form(uri, lang: snippet.language, code: snippet.plain_code)
    # snippet.update_attribute(:highlighted_code, request.body)
  end
end