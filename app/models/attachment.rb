class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentInvoicesUploader
  mount_uploader :file_processed, AttachmentInvoicesUploader

  belongs_to :user
  has_many :invoices, dependent: :delete_all

  validates :file, presence: true
end
