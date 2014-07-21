require 'rails_helper'

class DummyClass; end

describe RV::Mailer do

  let(:klass) { DummyClass.new.extend(RV::Mailer) }
  let(:alice) { FactoryGirl.create(:alice) }
  let(:post) { Post.create title: 'ruby rspec', body: 'This is first espec test: ruby' }

  it 'valid' do
    expect { klass.compose_mail(post, user: alice, to: 'dummy@example.com') }.not_to raise_error
  end

  it 'missing post' do
    expect { klass.compose_mail(nil, user: alice, to: 'dummy@example.com') }.to raise_error
  end

  it 'missing user' do
    expect { klass.compose_mail(post, user: nil, to: 'dummy@example.com') }.to raise_error
  end

  it 'missing to' do
    expect { klass.compose_mail(post, user: alice, to: nil) }.to raise_error
  end

  it 'invalid to' do
    expect { klass.compose_mail(post, user: alice, to: 'invalid.email') }.to raise_error
  end

end
