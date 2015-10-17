class DesignApplication < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :neighbors
	belongs_to :lot
	accepts_nested_attributes_for :neighbors, :reject_if => :all_blank, :allow_destroy => true
	has_attached_file :image
	has_attached_file :image_two
	has_attached_file :image_three
	has_attached_file :image_four
	has_attached_file :image_five
	has_attached_file :drawing
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_two, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_three, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_four, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_five, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment_content_type :drawing, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
	validates :name, :tag_list, :note, presence: true
  	#validates :start_date,
  	#	date: { after: Proc.new { Time.now }}
  	#validates :end_date,
  	#	date: { after: :start_date }
	acts_as_votable
	acts_as_taggable
	filterrific(default_filter_params: { sorted_by: 'created_at_desc' },
	  available_filters: [
	    :sorted_by,
	    :search_query,
	    :with_status,
	    :with_approved,
	  ]
	)

	scope :with_status, lambda { |status|
	  where(status: [*status])
	}

	scope :with_approved, lambda { |approved|
	  where(approved: [*approved])
	}

    scope :search_query, lambda { |query|
	    return nil  if query.blank?
	    # condition query, parse into individual keywords
	    terms = query.downcase.split(/\s+/)
	    # replace "*" with "%" for wildcard searches,
	    # append '%', remove duplicate '%'s
	    terms = terms.map { |e|
	      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	    }
	    # configure number of OR conditions for provision
	    # of interpolation arguments. Adjust this if you
	    # change the number of OR conditions.
	    num_or_conditions = 2
	    where(
	      terms.map {
	        or_clauses = [
	          "LOWER(design_applications.name) LIKE ?",
	          "LOWER(design_applications.description) LIKE ?",
	        ].join(' OR ')
	        "(#{ or_clauses })"
	      }.join(' AND '),
	      *terms.map { |e| [e] * num_or_conditions }.flatten
	    )
	}

	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
	    # Simple sort on the created_at column.
	    # Make sure to include the table name to avoid ambiguous column names.
	    # Joining on other tables is quite common in Filterrific, and almost
	    # every ActiveRecord table has a 'created_at' column.
	    order("design_applications.created_at #{ direction }")
	  when /^status_/
	    # Simple sort on the name colums
	    order("design_applications.status #{ direction }")
	  when /^name_/
	    # Simple sort on the name colums
	    order("design_applications.name #{ direction }")
	  when /^approved_/
	    # This sorts by a student's country name, so we need to include
	    # the country. We can't use JOIN since not all students might have
	    # a country.
	    order("design_applications.approved #{ direction }")
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
	}

	def self.options_for_sorted_by
	    [
	      ['Name (a-z)', 'name_asc'],
	    ]
	end

	def self.options_for_select
	  ['Desconocido', 'Hembra', 'Macho'].map { |value| [ value, value ] }
	end

end
