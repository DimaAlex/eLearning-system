require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(first_name:  "First",
                            last_name:   "Last",
                            email:       "user@example.com",
                            is_admin:    false,
                            country: "Example"
                            )
  }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:is_admin) }
  it { should respond_to(:country) }

end
