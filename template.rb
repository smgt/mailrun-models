class Template < ActiveRecord::Base

  attr_accessible :body_html, :body_text, :generate_text, :name, :subject
  attr_readonly :user_id, :ident

  belongs_to :user

  validates :name, :subject, presence: true

  before_create :assign_ident

  private

  def assign_ident
    ident = name.downcase.gsub(%r([^a-z\d\s]), "").strip.gsub(%r(\s), "-")
    self.ident = ident.blank? ? created_at.to_i.to_s : ident
  end

end
