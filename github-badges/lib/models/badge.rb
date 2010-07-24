class Badge
  attr_reader :name

  class << self
    def has_badge?(name)
      all.map(&:name).include? name
    end

    def add(badge_name, &block)
      Badge.new(badge_name, &block).tap do |new_badge|
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

  def initialize(name, &block)
    @name = name
    @badge_checker = block
  end

  def applicable_to?(user)
    @badge_checker.call(user)
  end
end
