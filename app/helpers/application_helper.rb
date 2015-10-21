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
    val = 1 if val.eql? 0
    return "#{str_int("#{(add.to_f/val.to_f)*100 || 0}".to_i)}%"
  end
end