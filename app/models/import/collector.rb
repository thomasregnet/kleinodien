module Import
  class Collector
    def self.call(...)
      new(...).call
    end

    def initialize(session, model:, presenter:)
      @session = session
      @model = model
      @presenter = presenter
    end

    attr_reader :session, :model, :presenter

    def call
      find || buffer && nil
    end

    def find
      finder = session.build_finder(presenter)
      finder.call
    end

    def buffer
      # prepare_belongs_to
      prepare_has_many_associations
      prepare_has_and_belongs_to_many_associations
    end

    def prepare_belongs_to
      associations = model.belongs_to_associations

      associations.each do |association|
        # ???
      end
    end

    def prepare_has_many_associations
      presenter.has_many_associations.each do |association|
        presenter_list = presenter.send association.name
        preparer_list = session.build_collector_list(presenter_list)
        preparer_list.each(&:call)
      end
    end

    def prepare_has_and_belongs_to_many_associations
    end
  end
end
