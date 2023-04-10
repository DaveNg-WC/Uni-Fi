module RegexMappingHelper
  REGEX_MAPPING = {
    /BUS|MRT|GRAB|TADA/ => 5,

    /GIANT|7-ELEVEN|NTUC/ => 6,

    /SUSHI|CHUAN|SHI|DON|MCDON|KOPITIAM|KFC|BURGER KING|SHI LI FANG|SUBWAY|FOODPANDA|SAIZERIYA|SUSHIRO|LONG JOHN|ISTEAKS/ => 7,

    /STRAN/ => 8,

    /AIRALO|EASYSHIP|ARKGRIT|REVOLUT|GIGA|DOCTORANYWHERE|SINGPOST|KINDLE|ADOBE|NIRVANAHQ|PAYPAL|EZBUY|GOTICKETING.COM/ => 9,

    // => 10
  }.freeze
end
