class User < ApplicationRecord
    # Password hashed
    has_secure_password

    # user have many todo with created_by on todos fields as a foreign key
    has_many :todos, foreign_key: :created_by

    # Validating presence
    validates_presence_of :name, :email, :password_digest
end
