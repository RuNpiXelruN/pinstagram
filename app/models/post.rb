class Post < ActiveRecord::Base
    validates :image, presence: true
    
    has_attached_file :image, styles: { large: "600x", medium: "300x", thumb: "100x" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    

end
