class Identity
  include Mongoid::Document

  belongs_to :user
  
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
  


  def self.find_for_oauth(auth)
    identity = find_or_create_by(provider: auth.provider, uid: auth.uid)
    identity.accesstoken = auth.credentials.token
    identity.refreshtoken = auth.credentials.refresh_token
    identity.name = auth.info.name
    identity.email = auth.info.email
    identity.nickname = auth.info.nickname
    identity.image = auth.info.image
    identity.phone = auth.info.phone
    identity.urls = (auth.info.urls || "").to_json
    identity.save
    identity
  end


end
