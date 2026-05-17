require 'date'

module Jekyll
  class MicroblogArchiveGenerator < Generator
    safe true
    priority :low

    def generate(site)
      collection = site.collections['microblog']
      return unless collection

      docs = collection.docs.sort_by(&:date)
      return if docs.empty?

      groups = {}
      docs.each do |doc|
        key = doc.date.strftime('%Y-%m')
        groups[key] ||= []
        groups[key] << doc
      end

      sorted_keys = groups.keys.sort

      site.data['microblog_months'] = sorted_keys.map do |key|
        year, month = key.split('-')
        {
          'year'       => year,
          'month'      => month,
          'month_name' => Date::MONTHNAMES[month.to_i],
          'count'      => groups[key].size,
          'url'        => "/microblog/#{year}/#{month}/"
        }
      end

      sorted_keys.each_with_index do |key, idx|
        year, month = key.split('-')
        month_name = Date::MONTHNAMES[month.to_i]
        entries = groups[key].sort_by(&:date).reverse

        page = Jekyll::PageWithoutAFile.new(site, site.source, "microblog/#{year}/#{month}", 'index.html')
        page.data.merge!(
          'layout'     => 'microblog_archive',
          'title'      => "Microblog — #{month_name} #{year}",
          'permalink'  => "/microblog/#{year}/#{month}/",
          'entries'    => entries,
          'year'       => year,
          'month'      => month,
          'month_name' => month_name,
          'sitemap'    => false,
          'prev_month' => idx > 0 ? site.data['microblog_months'][idx - 1] : nil,
          'next_month' => idx < sorted_keys.size - 1 ? site.data['microblog_months'][idx + 1] : nil
        )
        site.pages << page
      end
    end
  end
end
