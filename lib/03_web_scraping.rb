require 'nokogiri'
require 'open-uri'

# méthode pour scraper une page
def email_scraper(page_url)
  page = Nokogiri::HTML(URI.open(page_url))
  emails = []

  # itérer sur chaque élément de la liste pour extraire l'adresse email
  page.css('a.ann_mail').each do |email|
    if email.text.include?("@assemblee-nationale.fr")
      emails << email.text
    end
  end

  return emails
end

# afficher les adresses email contenant "@assemblee-nationale.fr"
puts "Liste des adresses email : "
emails = []
(1..58).each do |i|
  page_url = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&debut_deputes=#{(i-1)*100}#pagination_deputes"
  emails += email_scraper(page_url)
end

emails.each do |email|
  puts "- #{email}"
end