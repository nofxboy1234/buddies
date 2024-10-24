class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    @relation ||= Friendship.all
    @relation.unscope(where: :user_id)
    .where(user_id: user.id)
    .or(@relation.where(friend_id: user.id))
   },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) {
      @relation ||= User.all
      query = @relation.joins("OR users.id = friendships.user_id").where.not(id: user.id)
      query.where(friendships: { user_id: user.id })
        .or(query.where(friendships: { friend_id: user.id }))
    },
    through: :friendships
end
