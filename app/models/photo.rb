class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  private

  def photo_params
    params.require(:photo).permit(:content, :image)
  end
end
