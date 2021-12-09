class User < ApplicationRecord

  PASSWORD_FORMAT = /\A
  (?=.{10,16}$)      # 10 to 16 characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?:([\w\d*?!:;])\1?(?!\1))+  # Should not contain three repeating characters.
/x

  validates :password,
            presence: true,
            length: { :within => 10..16 },
            format: { with: PASSWORD_FORMAT },
            on: :create

end
