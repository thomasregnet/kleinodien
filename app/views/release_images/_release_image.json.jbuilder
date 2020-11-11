json.extract! release_image, :id, :front, :back, :note, :release_id, :archive_org_code, :created_at, :updated_at
json.url release_image_url(release_image, format: :json)
