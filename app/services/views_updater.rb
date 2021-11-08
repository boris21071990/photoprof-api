class ViewsUpdater
  attr_reader :viewable, :ip, :view_date

  def initialize(viewable, ip, view_date)
    @viewable = viewable
    @ip = ip
    @view_date = view_date
  end

  def call
    return Result.success(viewed: true) if viewed?

    create_view

    Result.success(viewed: false)
  end

  private

  def viewed?
    View.exists?(view_hash: view_hash)
  end

  def view_hash
    @view_hash ||= Digest::MD5.hexdigest([viewable.class.to_s, viewable.id, ip, view_date].join(""))
  end

  def create_view
    View.create(viewable: viewable, view_date: view_date, view_hash: view_hash)
  end
end
