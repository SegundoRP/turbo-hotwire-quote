class Quote < ApplicationRecord
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }

  # syntactic sugar,  By default, the target option will be equal to model_name.plural, which is equal to "quotes" in the context
  # of our Quote model. Thanks to this convention, we can remove the target: "quotes"
  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self } }


  # The partial default value is equal to calling to_partial_path on an instance of the model, which by default in Rails for our
  # Quote model is equal to "quotes/quote" // The locals default value is equal to { model_name.element.to_sym => self } which, in
  # the context of our Quote model, is equal to { quote: self }
  # after_create_commit -> { broadcast_prepend_to "quotes" }
  # after_update_commit -> { broadcast_replace_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # asynchronously, with active job
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  ##  The broadcast_remove_later_to method does not exist because as the quote gets deleted from the database,
  ## it would be impossible for a background job to retrieve this quote in the database later to perform the job.
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # Broadcasting Turbo Streams asynchronously is the preferred method for performance reasons.

  # Those three callbacks(asynchronously) are equivalent to the following single line
  # broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend


  # code above broadcasts data to all users and i want to broadcast to the same company users
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end
