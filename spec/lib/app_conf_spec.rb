require 'app_conf'

describe AppConf::Configurator do
  it 'returns shallow values' do
    config = AppConf::Configurator.new 'key' => 'value'
    expect(config.key).to eq 'value'
  end

  it 'returns method not found if no config matches' do
    config = AppConf::Configurator.new 'key' => 'value'
    expect{config.foo}.to raise_error(NoMethodError)
  end

  it 'returns nested values' do
    config = AppConf::Configurator.new 'parent' => {'child' => 'value'}
    expect(config.parent.child).to eq 'value'
  end

  it 'returns listed nested values' do
    config = AppConf::Configurator.new 'parent' => [{'child' => 'value1'}, [{'child' => 'value2'}] ]
    expect(config.parent[0].child).to eq 'value1'
    expect(config.parent[1][0].child).to eq 'value2'
  end

  it 'raises an error if a config key conflicts with a BasicObject method' do
    expect{AppConf::Configurator.new 'new' => 'value'}.to raise_error("'new' is reserved.")
  end

  it 'allows methods that are in object but not basic object' do
    config = AppConf::Configurator.new 'object_id' => 'value'
    expect(config.object_id).to eq 'value'
  end

end
