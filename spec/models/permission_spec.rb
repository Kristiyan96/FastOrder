# frozen_string_literal: true
# == Schema Information
#
# Table name: permissions
#
#  id            :integer          not null, primary key
#  subject_class :string
#  action        :string
#  name          :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Permission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
