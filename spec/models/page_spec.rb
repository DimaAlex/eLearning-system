require 'rails_helper'

RSpec.describe Page, type: :model do
  before { @page = Page.new(title: "Example",
                            body: "Example",
                            page_type: "Example"
                            )
  }

  subject { @page }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:page_type) }
end
