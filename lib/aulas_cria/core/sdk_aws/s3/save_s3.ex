defmodule AulasCria.Core.SdkAws.S3 do
  @doc """
    upload file to s3
  """
  def upload_file(bucket_name, upload_key, binary) do
    result =
      bucket_name
      |> ExAws.S3.put_object(upload_key, binary)
      |> ExAws.request!()

    case result do
      {:error, reason} -> {:error, reason}
      result -> {:ok, result}
    end
  end

  @doc """
    create a pre-signed url for file in s3
  """
  def make_presigned_url(bucket, path) do
    result =
      ExAws.Config.new(:s3)
      |> ExAws.S3.presigned_url(:get, bucket, path)

    case result do
      {:ok, presigned_url} -> {:ok, presigned_url}
      {:error, reason} -> {:error, reason}
    end
  end
end
