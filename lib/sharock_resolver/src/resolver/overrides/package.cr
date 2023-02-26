module Shards
  class Package
    def sorted_versions
      available_versions
        .sort { |a, b| natural_sort(a, b) }
        .reverse
    end

    private def available_versions
      @available_versions ||= resolver.available_versions
    end
  end
end
