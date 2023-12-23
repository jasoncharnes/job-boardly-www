module FeaturesHelper
  def features
    @features ||= Spina::Resource.find_by(name: "features").pages.live.order(position: :asc)
  end
end
