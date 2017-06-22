module EntriesHelper
  def expired_entry(entry)
    if entry.expired_at < Time.zone.now
      klass = 'expired'
    else
      klass = ''
    end
    content_tag(:td, entry.expired_at.strftime("%d.%m.%Y"), class: klass)
  end
end
