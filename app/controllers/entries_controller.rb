class EntriesController < ApplicationController

  def new
    respond_with(@entry = Entry.new)
  end
end
