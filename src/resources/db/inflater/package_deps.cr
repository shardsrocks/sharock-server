module Sharock::Resources::Inflater
  module PackageDeps
    def inflate(responses)
      if responses.is_a? Array
        responses.map { |response| inflate_row(response) }.compact
      else
        [] of Entities::Rows::PackageDeps
      end
    end

    def inflate_one(response)
      inflate(response).first
    end

    protected def inflate_row(row)
      if row.is_a? Array
        Entities::Rows::PackageDeps.new(
          row[0] as Int32,  # id
          row[1] as Int32,  # package_id
          row[2] as Int64,  # version
          row[3] as String, # deps_data
          row[4] as Time    # created_at
        )
      else
        nil
      end
    end
  end
end
