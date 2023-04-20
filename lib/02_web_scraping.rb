require 'nokogiri'
require 'open-uri'

# Méthode pour récupérer l'adresse e-mail d'une mairie à partir de son URL
def get_mairie_email(mairie_url)
  page = Nokogiri::HTML(URI.open(mairie_url))
  td_with_email = page.css('td:contains("@")').first
  td_with_email ? td_with_email.text.strip : "email inconnu" # Si on trouve une adresse email dans la page, on la retourne, sinon on retourne "email inconnu"
end

# Méthode pour récupérer les adresses e-mail de toutes les mairies du Val d'Oise
def get_all_mairies_emails
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  page.css('.lientxt').map do |link|
    {
      name: link.text.capitalize,
      email: get_mairie_email("http://annuaire-des-mairies.com#{link['href'][1..-1]}")
    }
  end
end

# Récupération des adresses e-mail des mairies du Val d'Oise
mairies_emails = get_all_mairies_emails()

# Affichage des adresses e-mail des mairies du Val d'Oise
puts "Emails des mairies du Val d'Oise :"
mairies_emails.each do |mairie|
  puts "#{mairie[:name]} => #{mairie[:email]}"
end