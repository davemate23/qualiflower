class SyncController < ApplicationController
  def sync_config
     @sync_tables = ["Institute" , "Location","Job","JobCategory","Course","CourseStats"]
  end

  def sync
  if params[:text].present?
    Delayed::Job.enqueue(SyncWorker.new(params[:text]), -3, Time.now)
    flash[:success] = "#{params[:text]} Successfully Added to Sync."
  end
    redirect_to sync_sync_config_path
  end

end
