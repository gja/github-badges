class Badge
  attr_accessor :name, :description, :target, :measure

  class << self
    def has_badge?(name)
      all.map(&:name).include? name
    end

    def add(attributes={})
      Badge.new(attributes).tap do |new_badge|
        all << new_badge
      end
    end

    def clear_badges!
      @badges = []
    end

    def all
      @badges ||= []
    end
  end

  def initialize(attributes={})
    @name, @description, @target, @measure = attributes.values_at(:name, :description, :target, :measure)
  end

  def quantifiable?
    target.is_a?(Numeric)
  end

  def earned_by?(user)
    if quantifiable?
      progress(user) >= target
    else
      target.call(user)
    end
  end

  def progress(user)
    user.send(measure)
  end
end
