module AuthenticationHelper
  def should_deny_user_access
    expect(response).to redirect_to new_user_session_path
    expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
  end

  def should_deny_staff_access
    expect(response).to redirect_to new_staff_session_path
    expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
  end
end
