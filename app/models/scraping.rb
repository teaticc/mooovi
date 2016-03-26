class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = "/now/"

    while true do
      current_page = agent.get("http://eiga.com#{next_url}")
      elements = current_page.search('.m_unit h3 a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end
      next_link = current_page.at('.next_page')
      next_url = next_link[:href]
      break unless next_url
    end

    links.each do |link|
      get_product('http://eiga.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.moveInfoBox h1').inner_text
    image_url = page.at('.pictBox img')[:src] if page.at('.pictBox img')

    product = Product.where(title: title, image_url: image_url).first_or_initialize

    product.open_date = page.search('.opn_date strong').inner_text if page.search('.opn_date strong')

    product.detail = page.search('.outline p').inner_text if page.search('.outline p')

    product.director = page.at('.staffBox dl dd a').inner_text if page.at('.staffBox dl dd a')

    product.save
  end

end