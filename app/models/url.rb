class Url < ActiveRecord::Base
  attr_accessible :full_url, :short_url, :redirect_count, :shortened_count
  
  has_many :user_urls
  has_many :users, :through => :user_urls
  
  after_initialize    :initialize_shorten_me
  validates           :full_url, :presence => true, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :message => "Not a valid URL" } # , :uniqueness => { :scope => :users_id, :message => "You already created that short url." }
  validate            :validates_not_linked_to_codly, :validates_uniqueness_per_user
  after_validation    :increment_shortened_count # if it validates, it's safe to increment the # of times it was shortened. 
  before_save         :set_short_url # if it validates, it's safe to increment the # of times it was shortened.
  
  default_scope order("created_at DESC")

  def initialize_shorten_me
    @shorten_me = true
  end
  
  def dont_shorten_me
    @shorten_me = false
  end
    
  def increment_redirect_count
    update_attribute(:redirect_count, redirect_count + 1)
  end
  
  private
    
  def increment_shortened_count
    update_attribute(:shortened_count, shortened_count + 1)
  end
  
  def validates_not_linked_to_codly
    errors.add(:full_url, "can't link to cod.ly.") if (self.full_url.include?('cod.ly') || self.full_url.include?('http://codly') || self.full_url.include?('localhost'))
  end
  
  def validates_uniqueness_per_user
    self.dont_shorten_me if Url.find_by_full_url(self.full_url)
    return true if self.users.empty?
    if @user = User.find(self.users[0].id) and @user.urls.find_by_full_url(self.full_url)
      errors.add(:full_url, "You have already shortened this Url.")
    end
  end
  
  def set_short_url
    self.short_url = Url.create_short_url_path if @shorten_me
  end
  
  # characters to use when generating your short url path (0..9,a..z,A-Z)
  # 56,800,235,584 possibilities with the 62 based character set
  # 68,719,476,736 with 64 based (can add _ and -, maybe some others)
  CHARSET = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
  BASE = 62
  SHORT_URL_LENGTH = 6
  
  def self.create_short_url_path
    @short_url = ""
    for i in 1..SHORT_URL_LENGTH
      @short_url += CHARSET[rand(BASE)]
    end
    self.create_short_url_path if Url.find_by_short_url(@short_url)
    
    return @short_url
  end
end
