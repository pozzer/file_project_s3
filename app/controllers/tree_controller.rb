class TreeController  < ApplicationController
  require 'aws-sdk'
  before_filter :get_s3
  def index
    #list = s3.list_buckets
    #buckets = list.buckets
    #b_production = buckets.last
    @list_objects = @s3.list_objects({bucket: 'mead-productions', delimiter: "/"})
  end

  def show
    @list_objects = @s3.list_objects({bucket: 'mead-productions', prefix:"#{params[:id]}/", delimiter: "/"})
    render :index
  end

  private
    def get_s3
      @s3 = Aws::S3::Client.new(
        region: 'us-east-1',
        access_key_id: 'AKIAIINULSJCBNLPUA7A',
        secret_access_key: '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'
      )
    end
end
