module Jvm
  class ClassFile
    attr_accessor :magic, :minor_version, :major_version, :constant_pool_count, :constant_pool_items, :access_flags, :this_class, :super_class, :interfaces_count, :interfaces, :fields_count, :fields, :methods_count, :methods, :attributes_count, :attributes
  end
end