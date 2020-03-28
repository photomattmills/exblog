defmodule Exblog.ImageUploader do
  def upload(file_stream, object_key) do
     file_stream
     |> ExAws.S3.upload("mattdotpicturesimages", object_key, content_type: "image/jpeg", acl: :public_read) 
     |> ExAws.request(region: "us-west-2")
  end
end
