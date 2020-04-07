defmodule Exblog.ImageUploader do
  def upload(path, object_key) do
    path
    |> ExAws.S3.Upload.stream_file()
    |> ExAws.S3.upload(bucket(), object_key,
      content_type: "image/jpeg",
      acl: :public_read
    )
    |> ExAws.request(region: "us-west-2")
  end

  def delete(key) do
    ExAws.S3.delete_object(bucket(), key) |> ExAws.request!(region: "us-west-2")
  end

  def bucket, do: Application.get_env(:exblog, :s3_bucket, "test")
end
