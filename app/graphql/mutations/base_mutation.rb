module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include JwtAuthentication::ValidateJsonWebToken
    
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end
end
