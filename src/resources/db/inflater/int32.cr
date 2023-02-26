module Sharock::Resources::DB::Inflater
  module I32Inflater
    def inflate_i32(responses) : Array(Int32)
      if responses.is_a? Array
        responses.map { |response|
          if response.is_a? Array
            response[0].as(Int32)
          end
        }.compact
      else
        [] of Int32
      end
    end

    def inflate_first_i32(response) : Int32?
      inflate_i32(response).first?
    end
  end
end
