require 'spec_helper'

describe UserUrl do
  it { should belong_to :user }
  it { should belong_to :url }
end
