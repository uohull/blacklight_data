require_relative '../utils/general_init'
module Hull
  module Data
    class HeaderProperty
      include Hull::Utils::GeneralInit
      attr_accessor :name, :searchable, :displayable, :multivalued 

      def to_hash
        {
          name: @name,
          searchable: @searchable,
          displayable: @displayable,
          multivalued: @multivalued
        }
      end

    end
  end
end
