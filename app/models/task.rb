class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  paginates_per 10
  belongs_to :user
  enum status:{
    未着手:0, 着手中:1, 完了:2
  } 
  enum priority:{
    低:0, 中:1, 高:2
  } 
  enum admin:{
    true:0, false:1  } 
  scope :search_title, -> (title) {where("title LIKE ?", "%#{title}%")}
  scope :search_status, -> (status) {where(status: status)}

end
