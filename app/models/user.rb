class User < ApplicationRecord
  # In rails console:

  # User.select('users.id', 'users.name', 'friendships.user_id', 'friendships.friend_id')
  # .joins(:today_friendships)

  # User.select("users.id", "users.name", "friendships.user_id", "friendships.friend_id")
  # .joins(:friendships)
  # .where('friendships.created_at > ?', 1.week.ago)

  has_many :today_friendships,
   -> {
    where("friendships.created_at > ?", 1.week.ago)
   },
  inverse_of: :user,
  class_name: "Friendship",
  dependent: :destroy

  has_many :friendships,
   #  ->(user) {
   #   friendships = Friendship.unscope(where: :user_id)
   #   query1 = friendships.where(user_id: user.id) # {1}
   #   query2 = Friendship.where(friend_id: user.id) # {2}
   #   query1.or(query2)
   #  },
   inverse_of: :user,
   dependent: :destroy

  # SELECT "friendships".*
  # FROM "friendships"
  # WHERE ({1}"friendships"."user_id" = 1{1} {2}OR "friendships"."friend_id" = 1{2})

  has_many :friends,
    # ->(user) {
    #   User.joins("OR users.id = friendships.user_id") # {3}
    #     .where.not(id: user.id) # {4}
    # },
    through: :friendships

  # SELECT "users".*
  # FROM "users"
  # INNER JOIN "friendships"
  # ON "users"."id" = "friendships"."friend_id" {3}OR users.id = friendships.user_id{3}
  # WHERE ({1}"friendships"."user_id" = 1{1} {2}OR "friendships"."friend_id" = 1{2})
  # {4}AND "users"."id" != 1{4}
end
