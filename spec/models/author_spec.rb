require 'rails_helper'

RSpec.describe Author, type: :model do
  required_fields = %w(firstname lastname)
  other_fields = %w(biography)

  include_examples 'test fields', required_fields, other_fields

  it {should have_many(:books)}
  
  it '.to_s' do
    @author = create(:author)
    expect(@author.to_s).to eql("#{@author.firstname} #{@author.lastname}")
  end
end
