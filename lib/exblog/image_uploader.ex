defmodule Exblog.ImageUploader do
  def upload(path, object_key) do
    path
    |> IO.inspect()
    |> ExAws.S3.Upload.stream_file()
    |> ExAws.S3.upload("mattdotpicturesimages", object_key,
      content_type: "image/jpeg",
      acl: :public_read
    )
    |> ExAws.request(region: "us-west-2")
  end

  def delete(key) do
    ExAws.S3.delete_object("mattdotpicturesimages", key)
  end
end
