require 'spec_helper'

describe Entry do

  subject { FactoryGirl.create :entry }
  it { should validate_presence_of :name }
  it { should validate_presence_of :priority }
  it { should belong_to :user }
  
end
