RSpec.shared_examples "test fields" do |required_fields, other_fields|
  all_fields = required_fields + other_fields

  all_fields.each do |field|
    it {should have_db_column(field)}
    it {should respond_to(field)}
  end

  required_fields.each do |field|
    it {should validate_presence_of(field)}
  end
end
