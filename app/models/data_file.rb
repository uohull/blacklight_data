class DataFile < ActiveRecord::Base
  mount_uploader :file, FileUploader

  has_many :datasets, dependent: :destroy

  validates :name, presence: true

  # delegates to the file object current_path method
  def file_path
   file.current_path
  end

  def datasetable?
    Dataset.valid_content_types.include? self.content_type
  end

end
