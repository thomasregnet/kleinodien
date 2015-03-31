class TrackHeading < Track
  validates :heading, presence: true, blank: false
  alias_attribute :title, :heading
end
