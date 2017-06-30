require 'dbf'
namespace :import do

task people: :environment  do
  data = File.open('people.dbf')
  employees = DBF::Table.new(data)
  employees.each do |record|
    employee_name = "#{record.fam} #{record.im.first}.#{record.otc.first}"
    Employee.create(name: employee_name, department: record.ceh, uuid: record.tab_nom )
  end
end

end
