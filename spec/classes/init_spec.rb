require 'spec_helper'
describe 'singularity' do
  context 'with default values for all parameters' do
    it { should contain_class('singularity') }
  end
end
