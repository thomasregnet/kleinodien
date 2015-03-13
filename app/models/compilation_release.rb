class CompilationRelease < ActiveRecord::Base
  validates :head, presence: true
  validates :type, presence: true
  belongs_to(
    :head,
    class_name: CompilationHead,
    foreign_key: :compilation_head_id)
  has_many(
    :identifiers,
    class_name: CompilationIdentifier)
  has_many(
    :media,
    class_name: CompilationMedium,
    foreign_key: :compilation_release_id)
  validates_uniqueness_of :version, scope: :head, case_sensitive: false
  delegate :title, to: :head

  def date=(date)
    if date.class == Fixnum
      write_attribute(:date, date.to_s + '-01-01')
      write_attribute(:date_mask, 4)
    elsif date =~ /^\d\d\d\d$/
      write_attribute(:date, date + '-01-01')
      write_attribute(:date_mask, 4)
    elsif date =~ /^\d\d\d\d-\d\d$/
      write_attribute(:date, date + '-01')
      write_attribute(:date_mask, 6)
    elsif date =~ /^\d\d\d\d-\d\d-\d\d$/
      write_attribute(:date, date)
      write_attribute(:date_mask, 7)
    else
      write_attribute(:date, date)
    end
    date
  end
end
