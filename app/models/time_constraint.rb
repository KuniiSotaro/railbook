class TimeConstraint
    def matches?(request)
        current = Time.now
        current.hour >= 10 && current.hour < 18
    end
end
