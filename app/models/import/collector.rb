module Import
  class Collector
    def self.call(...)
      new(...).call
    end

    def initialize(session, model:, facade:)
      @session = session
      @model = model
      @facade = facade
    end

    attr_reader :session, :model, :facade

    def call
      find || buffer && nil
    end

    def find
      finder = session.build_finder(facade)
      finder.call
    end

    def buffer
      collect_belongs_to
      collect_has_many_associations
      collect_has_and_belongs_to_many_associations
    end

    def collect_belongs_to
      associations = facade.belongs_to_associations

      associations.each do |association|
        # ???
      end
    end

    def collect_has_many_associations
      facade.has_many_associations.each do |association|
        facade_list = facade.send association.name
        collector_list = session.build_collector_list(facade_list)
        collector_list.each(&:call)
      end
    end

    def collect_has_and_belongs_to_many_associations
    end
  end
end