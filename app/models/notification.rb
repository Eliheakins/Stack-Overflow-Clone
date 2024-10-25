class Notification < ApplicationRecord
    belongs_to :user

    def is_read
        update(read: true)
    end
end
