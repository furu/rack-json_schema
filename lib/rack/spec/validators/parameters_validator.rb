module Rack
  class Spec
    module Validators
      class ParametersValidator
        def initialize(spec, env)
          @spec = spec
          @env = env
        end

        def validate!
          parameters.each do |key, hash|
            hash.each do |type, constraint|
              ValidatorFactory.build(key, type, constraint, @env).validate!
            end
          end
        end

        private

        def parameters
          @spec.find_endpoint(@env).try(:[], "parameters") || []
        end
      end
    end
  end
end