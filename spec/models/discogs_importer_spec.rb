require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe DiscogsImporter, type: :model do
  describe "import releases" do
    context "import a CD release of one artist (AC/DC Highway To Hell)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(940468)
      end
      
      it "has imported the album" do
        expect(@release).to be_valid
        expect(@release.title).to eq('Highway To Hell')
        expect(@release).not_to be_new_record
      end

      it "has set the date" do
        expect(@release.date.to_s).to eq('2000-11-20')
        expect(@release.date.mask).to eq(7)
      end

      it "has imported the songs" do
        tracks = @release.tracks
        expect(tracks[0].release.title).to eq ('Highway To Hell')
        expect(tracks[4].release.title).to eq('Beating Around The Bush')
        expect(tracks[9].release.title).to eq('Night Prowler')
      end

      it "has imported the labels" do
        expect(@release.companies[0].company.name).to eq('Atlantic')
        expect(@release.companies[0].company_role.name).to eq('Label')
        expect(@release.companies[0].catalog_no).to eq('7567-92419-5')
      end

      it "has imported the countries" do
        expect(@release.countries[0].name).to eq('Germany')
        expect(@release.countries.length).to eq(1)
      end
      
      after(:all) { DatabaseCleaner.clean }
    end

    context "import a Compilation (Cannibal Corpse - Dead Human Collection)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(4462260)
      end
      
      it "has imported the album" do
        expect(@release).to be_valid
        expect(@release.title).
          to eq('Dead Human Collection: 25 Years Of Death Metal')
        expect(@release).not_to be_new_record
      end

      it "has imported the countries" do
        expect(@release.countries[0].name).to eq('Europe')
        expect(@release.countries.length).to eq(1)
      end
        
      it "has set the date" do
        expect(@release.date.to_s).to eq('2013-03-29')
        expect(@release.date.mask).to eq(7)
      end

      it "has imported the formats" do
        formats = @release.formats
        
        expect(formats[0].kind.name).to eq('All Media')
        expect(formats[0].quantity).to  eq(1)
        expect(formats[0].note).to      eq('Hardcover-Artbook')
        expect(formats[0].format_attributes[0].kind.name)
          .to eq('Limited Edition')

        expect(formats[1].kind.name).to eq('CD')
        expect(formats[1].quantity).to  eq(3)
        expect(formats[1].format_attributes[0].kind.name)
          .to eq('Compilation')

        expect(formats[2].kind.name).to eq('CD')
        expect(formats[2].quantity).to  eq(1)
        expect(formats[2].format_attributes[0].kind.name)
          .to eq('Album')

        expect(formats[3].kind.name).to eq('Vinyl')
        expect(formats[3].quantity).to  eq(1)
        expect(formats[3].format_attributes[0].kind.name)
          .to eq('12"')
        expect(formats[3].format_attributes[1].kind.name)
          .to eq('Picture Disc')
        expect(formats[3].format_attributes[2].kind.name)
          .to eq('Album')
      end

      it "has imported the identifiers" do
        expect(@release.identifiers.length).to eq(17)
        
        expect(@release.identifiers[0].code).to eq('039841518009')
        expect(@release.identifiers[0].disambiguation).to be_nil
        expect(@release.identifiers[0].type.name).to eq('Barcode')

        expect(@release.identifiers[1].code)
          .to eq('Sony DADC A0102100183-0104 13 A00')
        expect(@release.identifiers[1].disambiguation).to eq('CD 1')
        expect(@release.identifiers[1].type.name).to eq('Matrix / Runout')

        expect(@release.identifiers[16].code).to eq('GEMA')
        expect(@release.identifiers[16].disambiguation).to be_nil
        expect(@release.identifiers[16].type.name).to eq('Rights Society')
      end
                                             
      it "has imported the songs" do
        tracks = @release.tracks
        expect(tracks[0].release.title).to eq('Shredded Humans')
        expect(tracks.last.release.title).to  eq('Scourge Of Iron')
      end

      it "has imported the track headings" do
        tracks = @release.tracks
        expect(tracks[0].heading).to  eq('Cd 1')
        expect(tracks[0].release.title).to eq('Shredded Humans')
        
        expect(tracks[20].heading).to eq('Cd 2')
        expect(tracks[20].release.title).to eq('Devoured By Vermin')

        expect(tracks[42].heading).to eq('Cd 3')
        expect(tracks[42].release.title).to eq('Decency Defied')

        expect(tracks[60].heading).to eq('Torturing And Eviscerating Live')
        expect(tracks[60].release.title).to eq('A Skull Full Of Maggots')

        expect(tracks[72].heading).to eq('Torturing And Eviscerating Live')
        expect(tracks[72].release.title).to eq('A Skull Full Of Maggots') 
      end

      it "has imorted the label" do
        expect(@release.companies[0].company.name)
          .to eq('Metal Blade Records GmbH')
        expect(@release.companies[0].company_role.name).to eq('Label')
        expect(@release.companies[0].catalog_no).to eq('3984-15180-0')
      end
      
      after(:all) { DatabaseCleaner.clean }
    end

    context "import a double album (Aphrodite's Child - 666)" do
      before(:all) do
        DatabaseCleaner.start
        @release = DiscogsTestHelper.import_release(4298844)
      end

      it "has imported the album" do
        expect(@release).not_to be_new_record
      end

      it "has imported the countries" do
        expect(@release.countries[0].name).to eq('Germany')
        expect(@release.countries.length).to eq(1)
      end
      
      it "has set the date" do
        expect(@release.date.to_s).to eq('1972-01-01')
        expect(@release.date.mask).to eq(4)
      end

      it "has imported the songs" do
         tracks = @release.tracks
         expect(tracks.first.release.title).to eq('The System')
         expect(tracks.last.release.title).to  eq('Break')
      end

      it "has imported the credits" do
        expect(@release.credits.length).to eq(13)
        
        expect(@release.credits[0].artist_credit.name).to eq('Demis Roussos')
        expect(@release.credits[0].job.name).to eq('Bass, Backing Vocals')

        expect(@release.credits[12].artist_credit.name).to eq('Michel Ripoche')
        expect(@release.credits[12].job.name).to eq('Trombone')
      end
      
      it "has imorted the label" do
        expect(@release.companies[0].company.name).to eq('Vertigo')
        expect(@release.companies[0].company_role.name).to eq('Label')
        expect(@release.companies[0].catalog_no).to eq('6673 001')
      end

      after(:all) { DatabaseCleaner.clean }
    end
  end
end
