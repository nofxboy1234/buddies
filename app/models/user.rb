class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    query1 = Friendship.all.unscope(where: :user_id).where(user_id: user.id)
    query2 = Friendship.all.where(friend_id: user.id)
    query1.or(query2)
   },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) {
      query1 = User.all.joins("OR users.id = friendships.user_id")
        .where(friendships: { user_id: user.id })
      query2 = User.all.joins("OR users.id = friendships.user_id")
        .where(friendships: { friend_id: user.id })
      query1.or(query2).where.not(id: user.id)
    },
    through: :friendships
end

# SELECT "users".* FROM "users"

# INNER JOIN "friendships" ON
# "users"."id" = "friendships"."friend_id"
# OR
# users.id = friendships.user_id

# WHERE
# ("friendships"."user_id" = $1 OR "friendships"."friend_id" = $2)
# AND
# "users"."id" != $3

# [["user_id", 1], ["friend_id", 1], ["id", 1]]

# -----------------------------------------------

# SELECT "users".* FROM "users"

# INNER JOIN "friendships" ON
# "users"."id" = "friendships"."friend_id"



# WHERE "friendships"."user_id" = $1




# [["user_id", 1]]
