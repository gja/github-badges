class Badge
  attr_accessor :name, :description, :target, :measure, :category

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
    @name, @description, @target, @measure, @category =
      attributes.values_at(:name, :description, :target, :measure, :category)
  end

  def quantifiable?
    target.is_a?(Numeric) || target.is_a?(Array)
  end

  def earned_by?(user)
    case target
    when Array
      target.include? progress(user)
    when Numeric
      progress(user) >= target
    else
      target.call(user)
    end
  end

  def quantification_criteria(user)
    case target
    when Array
      "(#{progress(user)} not one of #{target.join(", ")})"
    when Numeric
      "(#{progress(user)} / #{target})"
    else ""
    end
  end

  def progress(user)
    user.send(measure)
  end
end
