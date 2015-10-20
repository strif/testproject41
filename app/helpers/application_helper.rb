module ApplicationHelper
  def str_int(int)
    if int >= 0
      return "+#{int}"
    else
      return "#{int}"
    end
  end

  def get_percent(add, val)
    return "#{str_int("#{(add.to_f/val.to_f)*100 || 0}".to_i)}%"
  end

  def process_keywords(keywords_init)
    keywords_init.map do |query, data|
      {
        :query => query,
        :all_impressions => data.map {|s| s['impressions']}.reduce(0, :+),
        :s_impressions => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['impressions']}.reduce(0, :+),
        :c_impressions => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['impressions']}.reduce(0, :+),
        :all_clicks => data.map {|s| s['clicks']}.reduce(0, :+),
        :s_clicks => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['clicks']}.reduce(0, :+),
        :c_clicks => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['clicks']}.reduce(0, :+),
        :all_avg_position => data.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :s_avg_position => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :c_avg_position => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :s_ctr => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['ctr']}.reduce(0, :+).to_i,
        :c_ctr => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['ctr']}.reduce(0, :+).to_i,
        type: data.first[:type]
      }
    end
  end

  def process_keywords_date(keywords_init)
    keywords_init.map do |query, data|
      {
        :date => query,
        :query => data.uniq!{|s| s[:query]}.count
      }
    end
  end
end
