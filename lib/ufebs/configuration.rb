module Ufebs
  class Configuration
    attr_accessor :standard

    def schemas
      schemas_file = if standard == '2018'
        File.expand_path '../../../XMLSchemas_2018/cbr_ed_kbr_v2018.1.1.xsd', __FILE__ 
      else
        File.expand_path '../../../XMLSchemas/cbr_ed_kbr_v2017.4.2.xsd', __FILE__
      end
    end
  end
end