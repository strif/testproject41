# == Schema Information
#
# Table name: data_files
#
#  id         :integer          not null, primary key
#  name       :string
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DataFile < ActiveRecord::Base
  validates :file, presence: true
  mount_uploader :file, FileUploader

  after_create :set_file_name

  #
  # set field file name with file's name after file successfully created
  #
  def set_file_name
    update(name: (file.filename rescue "Untitled File"))
  end

  #
  # set field file name with file's name after file successfully created
  #
  def set_file_name
    update(name: (file.filename rescue "Untitled File"))
  end
end
