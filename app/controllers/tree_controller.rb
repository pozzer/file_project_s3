class TreeController  < ApplicationController
  require 'aws-sdk'
  before_action :get_s3

  def index
    #buckets = list.buckets
    @list_objects = @s3.list_objects({bucket: @bucket_name, delimiter: '/'})
  end

  def show
    @list_objects = @s3.list_objects({bucket: @bucket_name, prefix:"#{params[:id]}/", delimiter: "/"})
    render :index
  end

  def download
    key = params[:key]
    file_name = key.split("/").last
    object = @s3.get_object({bucket:@bucket_name, key: key})
    send_data object.body.read,  :filename => file_name
  end

  private
    def get_s3
      get_bucket
      @s3 = Aws::S3::Client.new
    end

    def get_bucket
      @bucket_name = 'mead-productions'
    end
end
