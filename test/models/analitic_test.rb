# == Schema Information
#
# Table name: analitics
#
#  id           :integer          not null, primary key
#  query        :string
#  impressions  :integer
#  clicks       :integer
#  ctr          :decimal(5, 2)
#  avg_position :decimal(5, 2)
#  date         :date
#  new          :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class AnaliticTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
