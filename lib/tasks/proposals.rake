namespace :proposals do
  desc "promote home page proposals"
  task :promote => :environment do
    Proposal.all.each {|p| p.position = nil; p.save!}
    
    top_proposals = ["Proyecto de Ley de Economía Sostenible", 
      "Proposición de Ley de creación del Consejo General de Colegios Oficiales de Ingeniería en Informática", 
      "Proposición de Ley de mejora de la transparencia en la información sobre la ejecución de la inversión del Sector Público Estatal", 
      "Proyecto de Ley del régimen de cesión de tributos del Estado a la Comunidad Autónoma de la Región de Murcia y de fijación del alcance y condiciones de dicha cesión", 
      "Proposición de Ley relativa a dotar de apoyo a las organizaciones sin ánimo de lucro"]
      
    top_proposals.each_with_index do |title, index|
      proposal = Proposal.find_by_title(title)
      proposal.position = index + 1
      proposal.save!
    end
  end
end