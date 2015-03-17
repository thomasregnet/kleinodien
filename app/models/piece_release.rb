class PieceRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [ %w(date date), %w(date_mask mask) ]
  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  has_many :tracks
  delegate :title, to: :head

  # def date=(date)
  #   if date.class == Fixnum
  #     write_attribute(:date, date.to_s + '-01-01')
  #     write_attribute(:date_mask, 4)
  #   elsif date =~ /^\d\d\d\d$/
  #     write_attribute(:date, date + '-01-01')
  #     write_attribute(:date_mask, 4)
  #   elsif date =~ /^\d\d\d\d-\d\d$/
  #     write_attribute(:date, date + '-01')
  #     write_attribute(:date_mask, 6)
  #   elsif date =~ /^\d\d\d\d-\d\d-\d\d$/
  #     write_attribute(:date, date)
  #     write_attribute(:date_mask, 7)
  #   else
  #     write_attribute(:date, date)
  #   end
  #   date
  # end
end
