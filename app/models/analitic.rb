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

class Analitic < ActiveRecord::Base
  attr_accessor :file, :start_date, :end_date, :compared_to_start_date, :compared_to_end_date

  class << self
    #
    # get data based on dates
    # this query could be using for selected and compared date
    #
    def get_data_based_on_dates(analitic, type)
      if type.eql? "selected"
        where(date: analitic[:start_date]..analitic[:end_date])
      elsif type.eql? "compared"
        where(date: analitic[:compared_to_start_date]..analitic[:compared_to_end_date])
      end
    end
  end
end