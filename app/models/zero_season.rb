class ZeroSeason < Season
  belongs_to :serial, class_name: PodcastSerial, foreign_key: :serial_id
  validates :serial, presence: true
  validates :no, inclusion: { in: [0] }
  after_initialize :init

  private
  
  def init
    self.no ||= 0
  end
end
