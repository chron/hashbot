class Setting
  include DataMapper::Resource

  property :setting, String, key: true
  property :value, Text, lazy: false

  def self.[](setting)
    get(setting).try(:value)
  end

  def self.[]=(setting, value)
    s = first_or_create(setting: setting)
    s.value = value
    s.save
  end
end
