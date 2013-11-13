class TypeEffect < ActiveRecord::Base
  belongs_to :type

  def other
    ::Type.find_by_id(other_type_id)
  end

  def name
    type.name
  end
end
