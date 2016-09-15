module TeamsHelper

  def panel_tag options
    style_class = options[:class] || "panel-info"
    title = options[:title]
    body = options[:body]

    render partial: 'helpers/panel', locals: {style_class: style_class, title: title, body: body}
  end

  def table_tag options={data_array: [[]], headings: [], table_heading: nil, style_class: nil, id: nil}
    options[:style_class] ||= "table table-hover"
    render partial: 'helpers/table', locals: { data_array: options[:data_array],
                                               headings: options[:headings],
                                               style_class: options[:style_class],
                                               table_heading: options[:table_heading],
                                               id: options[:id]
                                             }
  end

end