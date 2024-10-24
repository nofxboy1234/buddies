class User < ApplicationRecord
  has_many :friendships,
   ->(user) {
    @relation ||= Friendship.all

    query = @relation.unscope(where: :user_id)

    query = query.where(user_id: user.id)
    .or(@relation.where(friend_id: user.id))
   },
   inverse_of: :user,
   dependent: :destroy

  has_many :friends,
    ->(user) {
      @relation ||= User.all

      query = @relation.joins("OR users.id = friendships.user_id")

      query = query.where(friendships: { user_id: user.id })
      .or(query.where(friendships: { friend_id: user.id }))

      query = query.where.not(id: user.id)
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
