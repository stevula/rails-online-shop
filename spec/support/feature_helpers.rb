def sign_up
    visit "/users/sign_up"

    fill_in "Email",                 :with => "alindeman@example.com"
    fill_in "Password",              :with => "ilovegrapes"
    fill_in "Password confirmation", :with => "ilovegrapes"

    click_button "Sign up"
end

def sign_in(user)
  visit "users/sign_in"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
  end
