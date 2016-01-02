module Sharock::Resources::Inflater
  module Package
    def inflate(responses)
      if responses.is_a? Array
        responses.map { |response| inflate_row(response) }.compact
      else
        [] of Entities::Rows::Package
      end
    end

    def inflate_one(response)
      inflate(response).first?
    end

    protected def inflate_row(row)
      if row.is_a? Array
        Entities::Rows::Package.new(
          row[0] as Int32,  # id
          row[1] as String, # host
          row[2] as String, # owner
          row[3] as String, # repo
          row[4] as Time    # created_at
        )
      else
        nil
      end
    end
  end
end
