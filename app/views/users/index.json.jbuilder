json.array!(@users) do |user|
  json.extract! user, :id, :uid, :access_token, :expire, :q1, :q2, :q3, :masters, :email, :age, :birth_date, :optin
  json.url user_url(user, format: :json)
end
