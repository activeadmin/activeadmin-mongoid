module ActiveAdmin
  module Mongoid
    module Adaptor
      class Search
        attr_reader :base, :query, :query_hash, :search_params

        def initialize(object, search_params = {})
          @base = object
          @search_params = search_params
          @query_hash = get_query_hash(search_params)
          @query = @base.where(@query_hash)
        end

        def respond_to?(method_id)
          @query.send(:respond_to?, method_id)
        end

        def method_missing(method_id, *args, &block)
          if is_query(method_id)
            @search_params[method_id.to_s]
          else
            @query.send(method_id, *args, &block)
          end
        end

        private

        def is_query(method_id)
          method_id.to_s =~ /_contains$/
        end

        def get_query_hash(search_params)
          searches = search_params.map do|k, v|
            mongoidify_search(k,v)
          end
          Hash[searches]
        end

        def mongoidify_search(k, v)
          if k =~ /_contains$/
            [get_attribute(k), Regexp.new(Regexp.escape("#{v}"), Regexp::IGNORECASE)]
          else
            [k, v]
          end
        end

        def get_attribute(k)
          k.match(/^(.*)_contains$/)[1]
        end
      end
    end
  end
end