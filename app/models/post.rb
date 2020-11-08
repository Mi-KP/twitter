class Post < ApplicationRecord

    validates :content, {presence:true}
    validates :content, {length: {maximum: 140}}

    def user
        return User.find_by(id: self.user_id)
    end
end
