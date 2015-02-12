class OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def instagram
#     generic_callback( 'instagram' )
#   end

#   def facebook
#     generic_callback( 'facebook' )
#   end

#   def twitter
#     generic_callback( 'twitter' )
#   end

#   def generic_callback( provider )
#     @identity = Identity.find_for_oauth env["omniauth.auth"]

#     @user = @identity.user || current_user
#     if @user.nil?
#       @user = User.create( email: @identity.email || "" )
#       @identity.update_attribute( :user_id, @user.id )
#     end

#     if @user.email.blank? && @identity.email
#       @user.update_attribute( :email, @identity.email)
#     end

#     if @user.persisted?
#       @identity.update_attribute( :user_id, @user.id )
#       # This is because we've created the user manually, and Device expects a
#       # FormUser class (with the validations)
#       @user = FormUser.find @user.id
#       sign_in_and_redirect @user, event: :authentication
#       set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
#     else
#       session["devise.#{provider}_data"] = env["omniauth.auth"]
#       redirect_to new_user_registration_url
#     end
#   end

    def setup
      request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
      render :text => "Setup complete.", :status => 404
    end
# end

 skip_before_filter :verify_authenticity_token
  def all
    auth = request.env["omniauth.auth"]
    # Find an identity here
    @identity = Identity.all.find_by(:uid => auth.uid, :provider => auth.provider)

    if @identity.nil?
    # If no identity was found, create a brand new one here
      @identity = Identity.create(:uid => auth.uid, :provider => auth.provider)
    end
    if signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it 
        # is the current user. So the identity is already associated with 
        # this user. So let's display an error message.
        redirect_to user_url, notice: "Already linked that account!"
      else
        # The identity is not associated with the current_user so lets 
        # associate the identity
        @identity.user = current_user
        @identity.save()
        redirect_to user_url, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's 
        # just log them in here
        user = @identity.user
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        # Logic for the case when we actually need to create a new user
          user = User.from_omniauth(auth)
          if user.persisted?
            flash.notice = "Signed in!"
            sign_in_and_redirect user
          else
            session["devise.user_attributes"] = user.attributes
            redirect_to new_user_registration_url
          end
        end
      end
    end
  alias_method :facebook, :all
  alias_method :twitter, :all
  alias_method :instagram, :all 
end
