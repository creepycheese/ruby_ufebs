module Ufebs
  class Configuration
    attr_accessor :standard

    def schemas
      schemas_hash[standard]
    end

    def schemas_hash
      {
        '2017' => File.expand_path('../../../XMLSchemas/cbr_ed_kbr_v2017.4.2.xsd', __FILE__),
        '2018' => File.expand_path('../../../XMLSchemas_2018/cbr_ed_kbr_v2018.3.2.xsd', __FILE__),
        '2019' => File.expand_path('../../../XMLSchemas_2019/cbr_ed_kbr_v2019.2.1.xsd', __FILE__),
        '2020' => File.expand_path('../../../XMLSchemas_2020/cbr_ed_kbr_v2020.2.0.xsd', __FILE__)
      }
    end
  end
end