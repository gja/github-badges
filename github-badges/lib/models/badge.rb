class Badge
  attr_reader :name, :description

  class << self
    def has_badge?(name)
      all.map(&:name).include? name
    end

    def add(attributes={}, &block)
      Badge.new(attributes, &block).tap do |new_badge|
        all << new_badge
      end
    end

    def clear_badges!
      @badges = []
    end

    def filter(user)
      @badges.select {|b| b.applicable_to?(user)}
    end

    def all
      @badges ||= []
    end
  end

  def initialize(attributes={}, &block)
    @name, @description = attributes.values_at(:name, :description)
    @badge_checker = block
  end

  def applicable_to?(user)
    @badge_checker.call(user)
  end
end
