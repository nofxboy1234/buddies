class User < ApplicationRecord
  has_many :friendships,
   ->(user) { FriendshipsQuery.both_ways(user_id: user.id) },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) { UsersQuery.friends(user_id: user.id, scope: true) },
    through: :friendships
end
