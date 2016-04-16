require 'rails_helper'

RSpec.describe Organization, type: :model do
  before { @organization = Organization.new(title: "Example",
                                            description: "Example",
                                            phone: "Example",
                                            image_file_name: "Example"
                                            )
  }

  subject { @organization }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:phone) }
  it { should respond_to(:image_file_name) }
end
