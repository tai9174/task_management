class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  enum status:{
    "---":0,
    未着手:1, 着手中:2, 完了:3
    
  }    
end
