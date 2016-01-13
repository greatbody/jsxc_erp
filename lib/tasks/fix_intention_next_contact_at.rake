namespace :fix do
  task :intention_next_contact => :environment do
    Intention.all.each do |intention|
      p "processing intention #{intention.id}"
      if intention.student.contact_logs.count > 0
        last_contact = intention.student.contact_logs.last
        intention.update(next_contact_at: last_contact.next_contact_at, current_status: last_contact.current_status)
      end
    end
    p "done"
  end

  task :add_new_role => :environment do
    Role.create(name: 'manage_student_source')
  end
end
