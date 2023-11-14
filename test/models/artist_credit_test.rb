require "test_helper"

class ArtistCreditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "join names" do
    artist_credit = ArtistCredit.new

    participant = Participant.new(name: "first")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, join_phrase: " feat. ", position: 0)

    participant = Participant.new(name: "second")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, position: 1)

    participant = Participant.new(name: "third")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, position: 2)

    assert_predicate artist_credit, :valid?
    assert_equal "first feat. second third", artist_credit.name
  end
end
