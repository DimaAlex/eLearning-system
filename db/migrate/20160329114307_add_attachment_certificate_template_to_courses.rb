class AddAttachmentCertificateTemplateToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :certificate_template
    end
  end

  def self.down
    remove_attachment :courses, :certificate_template
  end
end
