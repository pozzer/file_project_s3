require 'aws-sdk'

class TreeController  < ApplicationController

  before_action :get_s3

  def index
    #buckets = list.buckets

    @list_objects = @s3_client.list_objects({bucket: @bucket_name, delimiter: '/'})

  end

  def show
    @list_objects = @s3_client.list_objects({bucket: @bucket_name, prefix:"#{params[:id]}/", delimiter: "/"})
    render :index
  end

  def download
    key = params[:key]
    file_name = key.split("/").last
    object = @s3_client.get_object({bucket:@bucket_name, key: key})
    send_data object.body.read,  :filename => file_name
  end

  private
    def get_s3
      set_bucket_name
      @s3 = Aws::S3::Resource.new
      @s3_client = Aws::S3::Client.new
      @bucket = @s3.bucket(@bucket_name)
    end

    def set_bucket_name
      @bucket_name = 'mead-productions'
    end

    def new_bucket
      bucket = @s3.buckets.create('name', :acl => :public_read)
    end

    def new_folder
      @s3_client.put_object(bucket: @bucket_name, key: "teste/.keep")
    end
end
