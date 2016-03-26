class Product < ActiveRecord::Base
  has_many :reviews

  def review_average
    self.reviews.average(:rate).round
  end

  def self.review_average(a_product)
    a_product.reviews.average(:rate).round
  end
end