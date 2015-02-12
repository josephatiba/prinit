class Identity
  include Mongoid::Document

  embedded_in :user
  
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  field :provider, type: String
  field :accesstoken, type: String
  field :refreshtoken, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :nickname, type: String
  field :image, type: String
  field :phone, type: String
  field :urls, type: String
  
  # identity = User.identity.new

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    user.identity.accesstoken = auth.credentials.token
    user.identity.refreshtoken = auth.credentials.refresh_token
    user.uidentity.name = auth.info.name
    user.identity.email = auth.info.email
    user.identity.nickname = auth.info.nickname
    user.identity.image = auth.info.image
    user.identity.phone = auth.info.phone
    user.identity.urls = (auth.info.urls || "").to_json
    user.identity.save
    user.identity
  end


end
