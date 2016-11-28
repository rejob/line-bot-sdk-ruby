require 'spec_helper'

describe LineBot::Bot::API do

  it 'has a version number' do
    expect(LineBot::Bot::API::VERSION).not_to be nil
  end

end
