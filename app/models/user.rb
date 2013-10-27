require 'bcrypt'

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: 'Must be a valid email address'}
  has_and_belongs_to_many :criteria, join_table: "user_criteria"
  has_many :grader_scorecards, class_name: 'Scorecard', foreign_key: 'grader_id'
  has_many :gradee_scorecards, class_name: 'Scorecard', foreign_key: 'gradee_id'
  has_many :graders, through: :gradee_scorecards
  has_many :gradees, through: :grader_scorecards

  def slug_candidates
    [:email]
  end

  attr_accessible :email

  def random_string
    Time.new.to_f.to_s.gsub(/\./, '').concat((0...10).map{ ('a'..'z').to_a[rand(26)] }.join).split("").shuffle.join.concat(Time.new.to_f.to_s.gsub(/\./, ''))
  end

  def encrypt(string)
    Digest::SHA1.hexdigest string.to_s
  end

  def update_password
    self.link_hash = self.random_string
    self.salt = self.random_string
    self.password = BCrypt::Password.create("#{self.link_hash}#{self.salt}")
    self.save
  end

  def invite(email, msg_params={:type => 'login_request'})
    user = User.find_by_email(email.strip) || User.new({:email => email.strip})
    user.update_password
    msg_params[:user] = user
    UserMailer.invite(msg_params).deliver
    user
  end

  def check_link_hash(hash)
    match = BCrypt::Password.new(self.password) == "#{hash}#{self.salt}"
    self.update_password
    match
  end

  def gravatar_url
    hash = Digest::MD5.hexdigest(self.email.downcase.strip)
    "http://www.gravatar.com/avatar/#{hash}"
  end

end
