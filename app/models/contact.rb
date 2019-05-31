class Contact < ApplicationRecord
  include Activeable
  belongs_to :user
  belongs_to :vendor

  enum gender: {
    mr: 0,
    ms: 1,
    miss: 2,
    dr: 3,
    mrs: 4,
    prof: 5
  }

  enum certification: {
    auth_fail: -1,
    uncertified: 0,
    certified: 1
  }

  enum title: {
      staff: 'staff',
      supervisor: 'supervisor',
      manager: 'manager',
      director: 'director',
      gm: 'gm'
  }

  enum role: {
    buyer: 0,
    vendor: 1,
    both: 2
  }

  def appellation_full_name
    "#{self.gender&.titleize}. #{self.full_name}"
  end

  def full_name
    "#{self.name}"
  end

  def gender_last_name
    "#{self.gender&.titleize} #{self.last_name}"
  end

  def get_company_name
    company&.name + (self.user_id ? "  (Account)" : "  (Contact)")
  end

  def name_email
    "#{self.name}（#{self.email}）"
  end

end