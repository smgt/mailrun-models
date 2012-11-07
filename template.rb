class Template < ActiveRecord::Base

  # Attributes
  attr_accessible :body_html, :body_text, :generate_text, :name, :subject, :body
  attr_readonly :user_id, :ident

  # Relations
  belongs_to :user

  # Validations
  validates :name, :subject, presence: true

  # Callbacks
  before_create :assign_ident

  # Scopes
  scope :find_by_id_or_ident, lambda { |id| where("id = ? OR ident = ?", id, id) }

  def body=(body={})
    self.body_html = body[:html] if body[:html]
    self.body_text = body[:text] if body[:text]
  end

  def body
    {
      html: body_html,
      text: body_text
    }
  end

  private

  def assign_ident
    ident = name.downcase.gsub(%r([^a-z\d\s]), "").strip.gsub(%r(\s), "-")
    self.ident = ident.blank? ? Time.now.to_i.to_s : ident
  end

end
