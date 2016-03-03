require Rails.root.join('lib', 'rails_admin', 'custom_order_edit.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::CustomOrderEdit)
require Rails.root.join('lib', 'rails_admin', 'approve_review.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::ApproveReview)

RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    custom_order_edit
    delete
    show_in_app
    
    approve_review
    
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.model 'Order' do
    edit do
      include_all_fields
      # include_fields :state, :shipping_address, :billing_address
      # field :completed_date do
      #   visible do
      #     bindings[:view]._current_user.role.name == 'Admin'
      #   end
      # end
    end
  end
  
end
