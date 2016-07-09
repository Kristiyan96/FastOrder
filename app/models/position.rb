# == Schema Information
#
# Table name: positions
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  role_id       :integer
#  restaurant_id :integer
#

class Position < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
  belongs_to :restaurant
end
