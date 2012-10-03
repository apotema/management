require 'spec_helper'

describe User do
  
  subject { FactoryGirl.create :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :login }
  it { should have_many :entries }
  
end
