Sitemap::Generator.instance.load :host => "mywebsite.com" do

  # Sample path:
  #   path :faq
  # The specified path must exist in your routes file (usually specified through :as).

  # Sample path with params:
  #   path :faq, :params => { :format => "html", :filter => "recent" }
  # Depending on the route, the resolved url could be http://mywebsite.com/frequent-questions.html?filter=recent.
  Sitemap::Generator.instance.load :host => "scoutmaster.pro" do
    path :root, :priority => 1
    literal "/locations" #helpful for vanity urls layering search results
    resources :activities, :params => { :format => "html" }
    resources :locations, :objects => proc { Location.published }
    # example of added ResourceSync metadata elements
  end
  # Sample resource:
    # resources :locations

  # Sample resource with custom objects:
  #   resources :articles, :objects => proc { Article.published }

  # Sample resource with search options:
  #   resources :articles, :priority => 0.8, :change_frequency => "monthly"

  # Sample resource with block options:
  #   resources :activities,
  #             :skip_index => true,
  #             :updated_at => proc { |activity| activity.published_at.strftime("%Y-%m-%d") }
  #             :params => { :subdomain => proc { |activity| activity.location } }

end
