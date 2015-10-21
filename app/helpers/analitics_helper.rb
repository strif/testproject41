module AnaliticsHelper
  #
  # query data processing - related to impression - clicks - ctr - avg_position
  #
  def process_new_query_data(all_data, selected, compared, is_new_query)
    new_queries = {}

    new_queries[:data] = all_data.select {|data| data[:new].eql? is_new_query}
    new_queries[:selected_data] = selected.select {|data| data[:new].eql? is_new_query}
    new_queries[:compared_data] = compared.select {|data| data[:new].eql? is_new_query}

    new_queries[:impressions] = new_queries[:data].inject(0) {|sum, hash| sum + hash.impressions}
    new_queries[:selected_impressions] = new_queries[:selected_data].inject(0) {|sum, hash| sum + hash.impressions}
    new_queries[:compared_impressions] = new_queries[:compared_data].inject(0) {|sum, hash| sum + hash.impressions}

    new_queries[:clicks] = new_queries[:data].inject(0) {|sum, hash| sum + hash.clicks}
    new_queries[:selected_clicks] = new_queries[:selected_data].inject(0) {|sum, hash| sum + hash.clicks}
    new_queries[:compared_clicks] = new_queries[:compared_data].inject(0) {|sum, hash| sum + hash.clicks}

    new_queries[:ctr] = new_queries[:data].inject(0) {|sum, hash| sum + hash.ctr}
    new_queries[:selected_ctr] = new_queries[:selected_data].inject(0) {|sum, hash| sum + hash.ctr}
    new_queries[:compared_ctr] = new_queries[:compared_data].inject(0) {|sum, hash| sum + hash.ctr}

    new_queries[:avg_position] = new_queries[:data].inject(0) {|sum, hash| sum + hash.avg_position}
    new_queries[:selected_avg_position] = new_queries[:selected_data].inject(0) {|sum, hash| sum + hash.avg_position}
    new_queries[:compared_avg_position] = new_queries[:compared_data].inject(0) {|sum, hash| sum + hash.avg_position}

    return new_queries
  end

  #
  # process keywords for date
  #
  def process_keywords_date(keywords_init)
    keywords_init.map do |query, data|
      {
        :date => query,
        :query => data.uniq!{|s| s[:query]}.count
      }
    end
  end

  #
  # get total calculation and its differences - also its difference percentation
  #
  def total_calculation_process_for(object, new_queries, existing_queries)
    total_impression = new_queries[object.to_sym] + existing_queries[object.to_sym]
    total_difference = str_int((new_queries["selected_#{object}".to_sym] - new_queries["compared_#{object}".to_sym]) + (existing_queries["selected_#{object}".to_sym] - existing_queries["compared_#{object}".to_sym]))
    total_difference_on_percent = get_percent(total_difference, total_impression)
    text = object.capitalize if ["impressions", "clicks"].include? object

    return "#{total_impression} #{text} #{total_difference} (#{total_difference_on_percent})"
  end

  #
  # get calculation and its differences - also its difference percentation
  #
  def calculation_process_for(object, queries)
    total_impression = queries[object.to_sym]
    total_difference = str_int((queries["selected_#{object}".to_sym] - queries["compared_#{object}".to_sym]))
    total_difference_on_percent = get_percent(total_difference, total_impression)
    text = object.capitalize if ["impressions", "clicks"].include? object

    return "#{total_impression} #{text} #{total_difference} (#{total_difference_on_percent})"
  end

  #
  # get total calculation and its differences - also its difference percentation
  #
  def calculation_process_keyword_for(object, queries)
    total_impression = queries["selected_#{object}".to_sym]
    total_difference = str_int(queries["selected_#{object}".to_sym] - queries["compared_#{object}".to_sym])
    total_difference_on_percent = get_percent(total_difference, total_impression)
    text = object.capitalize if ["impressions", "clicks"].include? object

    return "#{total_impression} #{text} #{total_difference} (#{total_difference_on_percent})"
  end

  #
  # process keywords
  #
  def process_queries(queries_grouped)
    queries_grouped.map do |query, data|
      {
        :query => query,
        :all_impressions => data.map {|s| s['impressions']}.reduce(0, :+),
        :selected_impressions => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['impressions']}.reduce(0, :+),
        :compared_impressions => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['impressions']}.reduce(0, :+),
        :all_clicks => data.map {|s| s['clicks']}.reduce(0, :+),
        :selected_clicks => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['clicks']}.reduce(0, :+),
        :compared_clicks => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['clicks']}.reduce(0, :+),
        :all_avg_position => data.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :selected_avg_position => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :compared_avg_position => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['avg_position']}.reduce(0, :+).to_i,
        :selected_ctr => data.select {|a| a[:type].eql? 'selected' }.map {|s| s['ctr']}.reduce(0, :+).to_i,
        :compared_ctr => data.select {|a| a[:type].eql? 'compared' }.map {|s| s['ctr']}.reduce(0, :+).to_i,
        type: data.first[:type]
      }
    end
  end
end