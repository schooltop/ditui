module Activeable
  extend ActiveSupport::Concern

  included do
    enum active: {
      actived: 1,
      inactived: 0,
      deleted: -1
    }
  end

end