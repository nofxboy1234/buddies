class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    relationn = @relation ||= Friendship.all
    relationn.unscope(where: :user_id)
    .where(user_id: user.id)
    .or(relationn.where(friend_id: user.id))
   },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) {
      relationn = @relation ||= User.all
      query = relationn.joins("OR users.id = friendships.user_id").where.not(id: user.id)
      query.where(friendships: { user_id: user.id })
        .or(query.where(friendships: { friend_id: user.id }))
    },
    through: :friendships
end
