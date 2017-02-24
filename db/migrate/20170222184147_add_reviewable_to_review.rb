class AddReviewableToReview < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :reviewable, polymorphic: true
  end
end
