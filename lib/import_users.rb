class ImportUsers
  def initialize(params)
    @params = params
    @errors = []
  end

  def import
    CSV.foreach(@params, :headers => true) do |row|
      User.create(row.to_hash)
      validate_password(row)
    end
    return @errors
  end

  def validate_password(row)
    if row['password'].length < 10
      difference = 10 - row['password'].length
      @errors << "Change #{difference} character of #{row['name']}'s password"
    elsif row['password'].length > 16
      difference = row['password'].length - 16
      @errors << "Change #{difference} character of #{row['name']}'s password"
    elsif !(row['password'].match(/(.*[a-z].*)/)) || !(row['password'].match(/(.*[A-Z].*)/)) || !(row['password'].match(/(.*\d.*)/))
      @errors << "Change 1 character of #{row['name']}'s password"
    elsif row['password'].scan(/((.)\2{2,})/).map(&:first).present?
      @errors << "Change #{row['password'].scan(/((.)\2{2,})/).map(&:first).count} character of #{row['name']}'s password"
    else
      @errors << "#{row['name']} was successfully saved"
    end
  end
end
