class VendorProduct < ApplicationRecord
  # 客户产品

  include Activeable
  belongs_to :vendor
  has_many :vendor_product_specs, dependent: :destroy

  scope :total, -> {
    Rails.cache.fetch('publish_product_total', expires_in: 60.minute ) do
      count
    end
  }

  default_scope {
    order(hot_product: :desc, created_at: :desc)
  }

  enum instock: {
    instock: 1,
    out_of_stock: 0
  }

  enum hot_product: {
    normal: 0,
    hot: 1
  }

  def self.find_vendor_products(inquiry,contact=nil)
    if contact.present?
      [VendorProduct.create_with(hot_product: :normal).find_or_create_by(chemical_id: inquiry.chemical_id, contact_id: contact.id, company_id: contact.company_id)]
    else
      #公司销售未锁定且已认证，用户销售未锁定且已认证
      VendorProduct.includes(:contact,:company).select(:contact_id, :chemical_id)
      .where('companies.sale_locked = 0 && companies.certification = 1 && contacts.sale_locked = 0 && contacts.certification = 1 ')
      .where(chemical_id: inquiry.chemical_id).where.not(contact_id: inquiry.contact&.company&.contacts&.pluck(:id)).actived.instock.order('companies.vendor_payment_type desc, vendor_products.weight desc, vendor_products.updated_at desc').limit 20
    end
  end

  # 返回结果 失败-fail, 成功-success 进入审核列表-verification, 禁止销售商品-restriction, 产品已近存在更新库存状态-update
  # pre_view表示是否预览，预览不插入数据，只返回结果，默认为非预览
  def self.upload(vendor, cas, name, purity, instock_str, note, created_by, pre_view = false)
    return 'fail' if name.blank?
    # 参数处理
    name = name.to_s.strip
    purity = purity.to_s.strip
    instock = instock_str.to_s.strip.downcase == 'yes' ? 'instock' : 'out_of_stock'
    note = note.to_s.strip
      # 上传
      vendor_product = VendorProduct.find_or_initialize_by(vendor_id: vendor.id, name: name)
      if vendor_product.id.to_i == 0
        unless pre_view
          vendor_product.assign_attributes(vendor_id: vendor.id, hot_product: :normal, created_by: created_by.name)
          vendor_product.save
          vendor_product_spec = vendor_product.vendor_product_specs.build(instock: instock, spec_info: purity, note: note, created_by: vendor_product.created_by)
          vendor_product_spec.save
        end
        return 'Preverification success'
      else
        vendor_product_spec = VendorProductSpec.find_or_initialize_by(vendor_product_id: vendor_product.id, spec_info: purity)
        if vendor_product_spec.id.to_i == 0
          unless pre_view
            vendor_product_spec.assign_attributes(instock: instock, note: note, created_by: created_by.name )
            vendor_product_spec.save
          end
          return 'Preverification success'
        else
          unless pre_view
            vendor_product_spec.assign_attributes(instock: instock, note: note)
            vendor_product_spec.save
          end
          return 'Product status update'
        end
      end
  end
end