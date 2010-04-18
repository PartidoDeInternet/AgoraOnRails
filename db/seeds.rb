# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

proposers = [
  ["PSOE",                     "Grupo Parlamentario Socialista"],
  ["PP",                       "Grupo Parlamentario Popular en el Congreso"],
  ["Convergència i Unió",      "Grupo Parlamentario Catalán (Convergència i Unió)"],
  ["PNV",                      "Grupo Parlamentario Vasco (EAJ-PNV)"],
  ["Izquierda Unida",          "Grupo Parlamentario de Esquerra Republicana-Izquierda Unida-Iniciativa per Catalunya Verds"],
  ["Grupo Mixto",              "Grupo Parlamentario Mixto"],
  ["PSOE",                     "Senado Grupo Parlamentario Socialista"],
  ["PP",                       "Senado Grupo Parlamentario Popular en el Senado"],
  ["Convergència i Unió",      "Senado Grupo Parlamentario Catalán en el Senado de Convergencia i Unió"],
  ["PNV",                      "Senado Grupo Parlamentario de Senadores Nacionalistas"],
  ["Izquierda Unida",          "Senado Grupo Parlamentario de Entesa Catalana de Progrés"],
  ["Grupo Mixto",              "Senado Grupo Parlamentario Mixto"]
].each do |name, full_name|
  Proposer.find_or_create_by_full_name(:name => name, :full_name => full_name)
end