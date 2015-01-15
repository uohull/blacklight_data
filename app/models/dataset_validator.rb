class DatasetValidator < ActiveModel::Validator
  def validate(dataset)
    unless dataset.valid_content_types.include? dataset.content_type
      dataset.errors[:data_file] << "Incorrect content type"
    end 
  end
end