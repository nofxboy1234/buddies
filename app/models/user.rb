class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    relationn = @relation ||= Friendship.all
    relationn.unscope(where: :user_id)
    .where(user_id: user.id)
    .or(relationn.where(friend_id: user.id))

     # FriendshipsQuery.both_ways(user_id: user.id)
   },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) { UsersQuery.friends(user_id: user.id, scope: true) },
    through: :friendships
end
