class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    friendships = Friendship.unscope(where: :user_id)
    query1 = friendships.where(user_id: user.id) # {1}
    query2 = Friendship.where(friend_id: user.id) # {2}
    query1.or(query2)
   },
   inverse_of: :user,
   dependent: :destroy

  # SELECT "friendships".*
  # FROM "friendships"
  # WHERE ({1}"friendships"."user_id" = 1{1} {2}OR "friendships"."friend_id" = 1{2})

  has_many :friends,
    ->(user) {
      User.joins("OR users.id = friendships.user_id") # {3}
        .where.not(id: user.id) # {6}
    },
    through: :friendships

  # SELECT "users".*
  # FROM "users"
  # INNER JOIN "friendships"
  # ON "users"."id" = "friendships"."friend_id" {3}OR users.id = friendships.user_id{3}
  # WHERE
  # ({1}"friendships"."user_id" = 1{1} {2}OR "friendships"."friend_id" = 1{2})
  # {6}AND "users"."id" != 1{6}
end
