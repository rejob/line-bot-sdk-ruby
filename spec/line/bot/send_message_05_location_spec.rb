require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.allow_net_connect!

describe LineBot::Bot::Client do

  it 'pushes the location message' do
    uri_template = Addressable::Template.new LineBot::Bot::API::DEFAULT_ENDPOINT + '/message/push'
    stub_request(:post, uri_template).to_return { |request| {:body => request.body, :status => 200} }

    client = LineBot::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_id = 'user_id'
    message = {
      type: 'location',
      title: 'LINE Corporation.',
      address: 'Hikarie  Shibuya-ku Tokyo 151-0002',
      latitude: 35.61823286112982,
      longitude: 139.72824096679688,
    }
    response = client.push_message(user_id, message)

    expected = {
      to: user_id,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'replies the location message' do
    uri_template = Addressable::Template.new LineBot::Bot::API::DEFAULT_ENDPOINT + '/message/reply'
    stub_request(:post, uri_template).to_return { |request| {:body => request.body, :status => 200} }

    client = LineBot::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    reply_token = 'reply_token'
    message = {
      type: 'location',
      title: 'LINE Corporation.',
      address: 'Hikarie  Shibuya-ku Tokyo 151-0002',
      latitude: 35.61823286112982,
      longitude: 139.72824096679688,
    }
    response = client.reply_message(reply_token, message)

    expected = {
      replyToken: reply_token,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

end
