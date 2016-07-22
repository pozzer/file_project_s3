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

  def download
    key = params[:key]
    file_name = key.split("/").last
    object = @s3.get_object({bucket:@bucket_name, key: key})
    binding.pry

    #File.open(file_name, 'wb') do |file|
#    #  @s3.get_object({bucket:@bucket_name, key: key}) do |chunk|
#    #    file.write(chunk)
#    #  end
#    #end
#
#
    #File.open('filename', 'wb') do |file|
    #  reap = @s3.get_object({bucket:@bucket_name, key: key}, target: file)
    #end
    send_data object.body,  :filename => file_name
  end

  private


    def get_s3
      get_bucket
      @s3 = Aws::S3::Client.new(
        region: 'us-east-1',
        access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
      )
    end

    def get_bucket
      @bucket_name = 'mead-productions'
    end
end
