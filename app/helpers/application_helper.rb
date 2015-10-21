module ApplicationHelper
  #
  # return string containing (+) for positive number and (-) for negative number
  #
  def str_int(int)
    if int >= 0
      return "+#{int}"
    else
      return "#{int}"
    end
  end

  #
  # return string percent
  #
  def get_percent(add, val)
    return "#{str_int("#{(add.to_f/val.to_f)*100 || 0}".to_i)}%"
  end

  def calc_bar_value(data, start, endd)
    if endd.blank?
      data.reject{|a| a.avg_position < start }.count
    else
      data.reject{|a| a.avg_position < start }.reject!{|a| a.avg_position > endd }.count
    end
  end

  def calc_bar_color(data1, data2)
    data = [
      {blue: [calc_bar_value(data1, 1, 2), calc_bar_value(data2, 1, 2)]},
      {yellow: [calc_bar_value(data1, 2, 4), calc_bar_value(data2, 2, 4)]},
      {green: [calc_bar_value(data1, 5, 10), calc_bar_value(data2, 5, 10)]},
      {gray: [calc_bar_value(data1, 10, 20), calc_bar_value(data2, 10, 20)]},
      {light_gray: [calc_bar_value(data1, 20, nil), calc_bar_value(data2, 20, nil)]}
    ]
  end

  def dataset_format(array)
    array.map do |a|
      {
        label: "My First dataset",
        fillColor: "#{a.keys.first}",
        strokeColor: "rgba(220,220,220,0.8)",
        highlightFill: "rgba(220,220,220,0.75)",
        highlightStroke: "rgba(220,220,220,1)",
        data: [a[a.keys.first].first, a[a.keys.first].last]
      }
    end
  end

  def create_chart_data(selected_date, selected, compared_date, compared)
    datasets = dataset_format calc_bar_color(selected, compared)

    {
      labels: [selected_date, compared_date],
      datasets: datasets
    }
  end


  def ctr_group_calculation(data1, data2)
    ctr_group_position = {
      1 => {},
      2 => {},
      3 => {},
      4 => {},
      5 => {},
      6 => {},
      7 => {},
      8 => {},
      9 => {},
      10 => {},
    }

    data1 = data1.reject{|a| a.impressions.to_i < 100 }.reject{|a| a.avg_position.to_i > 10 }.group_by { |data| data.avg_position.to_i }
    data1 = data1.each do |position, data|
      {
        :position => position,
        :ctr_1 => data.map {|s| s.ctr.to_i}.reduce(0, :+)
      }
      ctr_group_position[position] = ctr_group_position[position].merge({1 => data.map {|s| s.ctr.to_i}.reduce(0, :+)})
    end

    data2 = data2.reject{|a| a.impressions.to_i < 100 }.reject{|a| a.avg_position.to_i > 10 }.group_by { |data| data.avg_position.to_i }
    data2 = data2.each do |position, data|
      {
        :position => position,
        :ctr_2 => data.map {|s| s.ctr.to_i}.reduce(0, :+)
      }
      ctr_group_position[position] = ctr_group_position[position].merge({2 => data.map {|s| s.ctr.to_i}.reduce(0, :+)})
    end
    
    ctr_group_position
  end

  def ctr_group_percent_calculation()

  end
end
