# frozen_string_literal: true
# == Schema Information
#
# Table name: permission_roles
#
#  id            :integer          not null, primary key
#  permission_id :integer
#  role_id       :integer
#  restaurant_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_permission_roles_on_permission_id  (permission_id)
#  index_permission_roles_on_restaurant_id  (restaurant_id)
#  index_permission_roles_on_role_id        (role_id)
#
# Foreign Keys
#
#  fk_rails_9dfcd238e1  (restaurant_id => restaurants.id)
#  fk_rails_c517d9a118  (permission_id => permissions.id)
#  fk_rails_e8b49f05fd  (role_id => roles.id)
#

FactoryGirl.define do
  factory :permission_role do
  end
end
