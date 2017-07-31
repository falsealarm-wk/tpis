class DocumentReleaseJob < ApplicationJob
  queue_as :default

  def perform
    @documents = Document.for_release
    @documents.update(taken: false)
  end

end
