require 'rails_helper'

RSpec.describe User, type: :model do
  # 1:m relationship
  it { should have_many(:todos) }

  # validating fields preserence
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
